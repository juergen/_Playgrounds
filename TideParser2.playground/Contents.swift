// Playground - noun: a place where people can play

import UIKit
import Foundation


// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))


func parseLine(checkpoint:Checkpoint, line:String) {
  //print("\(index) \(line)")
  let elements = line.spit("\t")
//  for element in elements {
//    print("\(element) | ")
//  }
//  print("")
  
  var dayString = yearMonth
  
  for (index, element) in elements.enumerate() {
    
    switch headers[index] {
      
    case "Day":
      dayString = yearMonth + element.substringFromIndex(4)
      
    case "High":
      if let meterPoint = parseTide(dayString, timeAndTide: element as String, tide: Tide.High) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case "Low":
      if let meterPoint = parseTide(dayString, timeAndTide: element as String, tide: Tide.Low) {
        checkPoint.meterPoints.append(meterPoint)
      }
      
    case "Moon":
      checkPoint.meterPoints.last?.moon = Moon(rawValue: element as String)
      
    default:
      ()
    }
  }
}


/// We have one Checkpoint to process
var checkPoint = Checkpoint()


// Parse info String line by line to add all available MeterPoint to our Checkpoint
for (index, line) in (info.spit("\n")).enumerate() {
  parseLine(checkPoint, line: line as String)
}

var previous:MeterPoint?

// Now we print the time and level difference from MeterPoint to MeterPoint
for (index, meterPoint) in (checkPoint.meterPoints).enumerate() {
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
