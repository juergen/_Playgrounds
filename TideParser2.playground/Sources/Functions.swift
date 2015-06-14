import Foundation

func p(printMe: Any) {
  print("\(printMe)")
}

func parseTide(dayString: String, timeAndTide: String, tide: Tide) -> MeterPoint? {
  if let time = timeAndTide.substringBefore(" EST") {
    if let dateTime = (dayString + " " + time).parseDate(pattern) {
      if let tideString = timeAndTide.substringBetweenExclude("/ ", last: " ft") {
        if let level = tideString.toFloat() {
          //println("\(dateTime) tide: \(level) \(tide.rawValue)")
          return MeterPoint(level: level, date: dateTime, tide:tide)
        }
      }
    }
  }
  return nil
}



