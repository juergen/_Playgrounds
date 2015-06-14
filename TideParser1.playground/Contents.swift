// Playground - noun: a place where people can play

import UIKit
import Foundation

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))

let yearMonth: String = "2015-02-"
let testParse = yearMonth + "1 6:29 AM"
let pattern = "yyyy-MM-dd h:mm a"
println("\(testParse.parseDate(pattern))")

// Day	High	Low	High	Low	High	Moon
let header: String = "Day\tHigh\tLow\tHigh\tLow\tHigh\tMoon"

let headers: [String]  = header.split("\t")

//println(info)


func parseLine(checkpoint:Checkpoint, line:String) {
  //println("\(index) \(line)")
  let elements: [String] = line.split("\t")
//  for element in elements {
//    print("\(element) | ")
//  }
//  println("")
  
  var dayString: String = yearMonth
  
  for (index, element) in enumerate(elements) {
    
    switch headers[index] {
      
    case "Day":
      dayString = yearMonth + (element as NSString).substringFromIndex(4)
      
    case "High":
      if let meterPoint = parseTide(dayString, element, Tide.High) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case "Low":
      if let meterPoint = parseTide(dayString, element, Tide.Low) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case let "Moon":
      checkPoint.meterPoints.last?.moon = Moon(rawValue: element)
      
    default:
      ()
    }
  }
}

var checkPoint = Checkpoint()

for (index, line) in enumerate(info.split("\n")) {
  parseLine(checkPoint, line)
}

var previous:MeterPoint?

for (index, meterPoint) in enumerate(checkPoint.meterPoints) {
  if index == 0 {
    println("\(meterPoint.display())")
    previous = meterPoint
    continue
  }
  var levelDif: Float = meterPoint.level! - previous!.level!
  var timeDif: Int = Int(meterPoint.date!.timeIntervalSince1970 - previous!.date!.timeIntervalSince1970)
  var hours = timeDif / 3600
  if (hours > 0) {
    var hourSeconds = hours * 3600
    timeDif = timeDif - hourSeconds
  }
  var minutes = timeDif / 60
  let timeDifInfo = "  " + hours.leftPad(2, pad: "0") + ":" + minutes.leftPad(2, pad: "0")
  println("  \(timeDifInfo)  \(levelDif)")
  println("\(meterPoint.display())")
  previous = meterPoint
}

