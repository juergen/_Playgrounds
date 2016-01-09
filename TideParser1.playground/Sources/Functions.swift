import Foundation

public func p(printMe: Any) {
  print("\(printMe)")
}


public func parseTide(pattern: String, dayString: String, timeAndTide: String, tide: Tide) -> MeterPoint? {
  if let time = timeAndTide.substringBefore(" EST"),
    let dateTime = (dayString + " " + time).parseDate(pattern),
    let tideString = timeAndTide.substringBetweenExclude("/ ", last: " ft"),
    let level = tideString.toFloat() {
      //println("\(dateTime) tide: \(level) \(tide.rawValue)")
      return MeterPoint(level: level, date: dateTime, tide:tide)
  }
  
  return nil
}

public func parseLine(yearMonth: String, pattern: String, checkpoint: Checkpoint, line: String) {
  //print("\(index) \(line)")
  let elements: [String] = line.split("\t")
  //  for element in elements {
  //    print("\(element)", separator:" | ")
  //  }
  //  print("")
  
  var dayString: String = yearMonth
  
  for (index, element) in elements.enumerate() {
    
    switch headers2[index] {
      
    case "Day":
      dayString = yearMonth + (element as NSString).substringFromIndex(4)
      
    case "High":
      if let meterPoint = parseTide(pattern, dayString: dayString, timeAndTide: element, tide: Tide.High) {
        checkpoint.meterPoints.append(meterPoint)
      }
      
    case "Low":
      if let meterPoint = parseTide(pattern, dayString: dayString, timeAndTide: element, tide: Tide.Low) {
        checkpoint.meterPoints.append(meterPoint)
      }
      
    case "Moon":
      checkpoint.meterPoints.last?.moon = Moon(rawValue: element)
      
    default:
      break
    }
  }
}

public func printCheckpoint(checkpoint: Checkpoint) {
  var previous:MeterPoint?
  for (index, meterPoint) in checkpoint.meterPoints.enumerate() {
    if index == 0 {
      print("\(meterPoint.display())")
      previous = meterPoint
      continue
    }
    let levelDif: Float = meterPoint.level! - previous!.level!
    var timeDif: Int = Int(meterPoint.date!.timeIntervalSince1970 - previous!.date!.timeIntervalSince1970)
    let hours = timeDif / 3600
    if (hours > 0) {
      let hourSeconds = hours * 3600
      timeDif = timeDif - hourSeconds
    }
    let minutes = timeDif / 60
    let timeDifInfo = hours.leftPad(2, pad: "0") + ":" + minutes.leftPad(2, pad: "0")
    print("    ∆t \(timeDifInfo)  ∆f \(levelDif)")
    print("\(meterPoint.display())")
    previous = meterPoint
  }
  
}