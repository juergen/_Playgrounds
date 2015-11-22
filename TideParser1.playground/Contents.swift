// 
// Tide Parser with Sources (Extensions, Functions, Domains etc.)
//

import UIKit
import Foundation

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))

let yearMonth: String = "2015-02-"
let testParse = yearMonth + "1 6:29 AM"
let pattern = "yyyy-MM-dd h:mm a"
print("\(testParse.parseDate(pattern))")

// Day	High	Low	High	Low	High	Moon
let header: String = "Day\tHigh\tLow\tHigh\tLow\tHigh\tMoon"

let headers: [String]  = header.split("\t")

//println(info)


func parseLine(checkpoint:Checkpoint, line:String) {
  //print("\(index) \(line)")
  let elements: [String] = line.split("\t")
//  for element in elements {
//    print("\(element)", separator:" | ")
//  }
//  print("")
  
  var dayString: String = yearMonth
  
  for (index, element) in elements.enumerate() {
    
    switch headers[index] {
      
    case "Day":
      dayString = yearMonth + (element as NSString).substringFromIndex(4)
      
    case "High":
      if let meterPoint = parseTide(dayString, timeAndTide: element, tide: Tide.High) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case "Low":
      if let meterPoint = parseTide(dayString, timeAndTide: element, tide: Tide.Low) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case "Moon":
      checkPoint.meterPoints.last?.moon = Moon(rawValue: element)
      
    default:
      ()
    }
  }
}

var checkPoint = Checkpoint()

for (index, line) in info.split("\n").enumerate() {
  parseLine(checkPoint, line: line)
}

var previous:MeterPoint?

for (index, meterPoint) in checkPoint.meterPoints.enumerate() {
  if index == 0 {
    print("\(meterPoint.display())")
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
  print("  \(timeDifInfo)  \(levelDif)")
  print("\(meterPoint.display())")
  previous = meterPoint
}

