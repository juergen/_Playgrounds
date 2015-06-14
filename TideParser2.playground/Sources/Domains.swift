import Foundation

enum Tide: String {
  case High = "High"
  case Low = "Low"
}

enum Moon: String {
  case FullMoon = "Full Moon"
  case LastQuarter = "Last Quarter"
  case NewMoon = "New Moon"
  case FirstQuarter = "First Quarter"
}

class MeterPoint {
  var level: Float?
  var date: NSDate?
  var tide:Tide?
  var moon:Moon?
  
  init(level:Float, date:NSDate, tide:Tide) {
    self.level = level
    self.date = date
    self.tide = tide
  }
  
  func display() -> String {
    return "\(date!) \(level!) \(tide!.rawValue) " + (moon?.rawValue ?? "")
    
  }
}

class Checkpoint {
  var meterPoints: [MeterPoint] = []
}