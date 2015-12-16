// Water level parser for http://www.gkd.bayern.de

// use DEBUG variable to switch between offline and online debugging
// if offline, demoData will be parsed

import UIKit
import Foundation
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))



let ONLINE = false

if ONLINE {
  print("\n**************** WE ARE ONLINE (see let ONLINE = \(ONLINE)) ****************\n")
} else {
  print("\n**************** WE ARE OFFLINE (see let ONLINE = \(ONLINE)) ****************\n")
}


let demoData =
"\"2015-04-01 00:15\";78,70;Rohdaten\n" +
  "\"2015-04-01 00:30\";80,10;Rohdaten\n" +
  "\"2015-04-01 00:45\";78,70;Rohdaten\n" +
  "\"2015-04-01 01:00\";;Rohdaten\n" +
  "\"2015-04-01 14:15\";80,10;Rohdaten\n" +
  "\"2015-04-01 14:30\";81,60;Rohdaten\n" +
  "\"2015-04-01 14:45\";81,60;Rohdaten\n" +
"\"2015-04-01 15:00\";;Rohdaten\n"

class MeterPoint {
  var level: Float?
  var date: NSDate?
  
  init(level:Float, date:NSDate) {
    self.level = level
    self.date = date
  }
  
  func display() -> String {
    return "MeterPoint: \(date!) \(level!)"
  }
  
}

class Checkpoint {
  var meterPoints: [MeterPoint] = []
}

func parseLine(checkpoint:Checkpoint, line:String) {
  print("will parse: \(line)")
  let elements: [String] = line.split(";")
  if let date = elements[0].parseDate("\"yyyy-MM-dd HH:mm\"") {
    if let value = elements[1].toFloat() {
      checkpoint.meterPoints.append(MeterPoint(level: value, date: date))
    }
  }
}

let predicate: String -> Bool = { $0.startsWith("\"20") || $0.startsWith("\"19") }

func parse(checkPoint: Checkpoint, parseMe: String) {
  
  parseMe.split("\n").filter(predicate).map {parseLine(checkPoint, line: $0)}
  
  for meterpoint in checkpoint.meterPoints {
    print("\(meterpoint.display())")
  }
  
}

var checkpoint: Checkpoint = Checkpoint()

// use next line to debug parser
if !ONLINE {
  parse(checkpoint, parseMe: demoData)
}


// url parameter produkt=
// wasserstand
// abfluss
let wasserstand:String = "wasserstand"
let abfluss:String = "abfluss"
let produkt:String = wasserstand

let url = NSURL(string: "http://www.gkd.bayern.de/fluesse/download/index.php?wertart=ezw&beginn=10.12.2015&ende=16.12.2015&msnr=16005701&prbstnr=&thema=gkd&rubrik=fluesse&produkt=\(produkt)&parameter=&mpnr1=&mpnr2=&dl=Download")
let session = NSURLSession.sharedSession()

let task = session.dataTaskWithURL(url!) {(data, response, error) in
  print("start task")
  if let data = NSString(data: data!, encoding: NSUTF8StringEncoding) {
    print("got data from", url)
    if let downloadUrl = (data as String).substringBetweenExclude(".innerHTML = 'Bitte <a href=\"", last: "\">hier</a> klicken falls Ihr Download") {
      print("Will download values from: \(downloadUrl)\n")
      print("produkt:", produkt, "\n")
      let downloadTask = session.dataTaskWithURL(NSURL(string: downloadUrl)!) {(data2, response, error) in
        print(NSString(data: data2!, encoding: NSISOLatin1StringEncoding))
        if let downloadData = NSString(data: data2!, encoding: NSISOLatin1StringEncoding) {
          parse(checkpoint, parseMe: downloadData as String)
        }
      }
      downloadTask.resume()
    }
  }
}

// comment next line to avoid http requests during debugging
if ONLINE {
  print("resume task")
  task.resume()
}

