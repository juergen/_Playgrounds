import Foundation

public enum Tide: String {
  case High = "High"
  case Low = "Low"
}

public enum Moon: String {
  case FullMoon = "Full Moon"
  case LastQuarter = "Last Quarter"
  case NewMoon = "New Moon"
  case FirstQuarter = "First Quarter"
}

public class MeterPoint {
  public var level: Float?
  public var date: NSDate?
  public var tide:Tide?
  public var moon:Moon?
  
  public init(level:Float, date:NSDate, tide:Tide) {
    self.level = level
    self.date = date
    self.tide = tide
  }
  
  public func display() -> String {
    return "\(date!) \(level!) \(tide!.rawValue) " + (moon?.rawValue ?? "")
    
  }
}

public class Checkpoint {
  
  public init(){ }
  
  public var meterPoints: [MeterPoint] = []
}