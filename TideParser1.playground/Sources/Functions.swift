import Foundation

public func p(printMe: Any) {
  println("\(printMe)")
}

public func parseTide(dayString: String, timeAndTide: String, tide: Tide) -> MeterPoint? {
  if let time = timeAndTide.substringBefore(" EST"),
    let dateTime = (dayString + " " + time).parseDate(pattern),
    let tideString = timeAndTide.substringBetweenExclude("/ ", last: " ft"),
    let level = tideString.toFloat() {
      //println("\(dateTime) tide: \(level) \(tide.rawValue)")
      return MeterPoint(level: level, date: dateTime, tide:tide)
  }
  
  return nil
}