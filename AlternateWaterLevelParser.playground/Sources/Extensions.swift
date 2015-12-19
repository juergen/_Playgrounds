import Foundation


// ----------------------------------------------------------------------------------------------------
// MARK: - String
// ----------------------------------------------------------------------------------------------------

public extension String {
  
  func split(separator:String) -> [NSString] {
    return self.componentsSeparatedByString(separator) as [NSString]
  }
  
  func split(separator:String) -> [String] {
    return self.componentsSeparatedByString(separator) as [String]
  }
  
  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
  
  func substringBetween(first: String, last: String) -> String? {
    if let start = self.rangeOfString(first)?.startIndex {
      if let end = self.rangeOfString(last, options:NSStringCompareOptions.BackwardsSearch)?.endIndex {
        return self.substringWithRange(start..<end)
      }
    }
    return nil
  }
  
  func substringBetweenExclude(first: String, last: String) -> String? {
    if let start = self.rangeOfString(first)?.endIndex {
      if let end = self.rangeOfString(last, options:NSStringCompareOptions.BackwardsSearch)?.startIndex {
        return self.substringWithRange(start ..< end)
      }
    }
    return nil
  }
  
  func indexOfCharacter(char: Character) -> Bool {
    if let idx = self.characters.indexOf(char) {
      return self.startIndex.distanceTo(idx) == 0
    }
    return false
  }
  
  var length: Int {
    get {
      return self.characters.count
    }
  }
  
  func indexOf(target: String) -> Int {
    let range = self.rangeOfString(target)
    if let range = range {
      return self.startIndex.distanceTo(range.startIndex)
    } else {
      return -1
    }
  }
  
  func indexOf(target: String, startIndex: Int) -> Int {
    let startRange = self.startIndex.advancedBy(startIndex)
    let range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
    if let range = range {
      return self.startIndex.distanceTo(range.startIndex)
    } else {
      return -1
    }
  }
  
  func lastIndexOf(target: String) -> Int {
    var index = -1
    var stepIndex = self.indexOf(target)
    while stepIndex > -1 {
      index = stepIndex
      if stepIndex + target.length < self.length {
        stepIndex = indexOf(target, startIndex: stepIndex + target.length)
      } else {
        stepIndex = -1
      }
    }
    return index
  }
  
  func startsWith(start:String) -> Bool {
    return self.indexOf(start) == 0
  }
  
  func substringWithRange(range:Range<Int>) -> String {
    let start = self.startIndex.advancedBy(range.startIndex)
    let end = self.startIndex.advancedBy(range.endIndex)
    return self.substringWithRange(start..<end)
  }
  
  func parseDate(format:String="yyyy-MM-dd") -> NSDate? {
    let dateFmt = NSDateFormatter()
    dateFmt.timeZone = NSTimeZone()
    dateFmt.dateFormat = format
    if let date = dateFmt.dateFromString(self) {
      return date
    }
    return nil
  }
  
  func replaceAll(replaceMe:String, replacement:String) -> String {
    return self.stringByReplacingOccurrencesOfString(replaceMe, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
  }
  
  func toFloat() -> Float? {
    if self.isEmpty {
      return nil
    }
    // we need to ignore e.g. "60 - 80" values
    if self.trim().rangeOfString(" ") != nil {
      return nil
    }
    let s = self.trim().replaceAll(",", replacement: ".")
    
    return (NSString(string: s).floatValue)
  }
  
}


// ----------------------------------------------------------------------------------------------------
// MARK: - NSDate
// ----------------------------------------------------------------------------------------------------

public extension NSDate {
  
  // MARK: - private API
  
  private func addComponents(seconds s: Int, minutes m: Int, hours h: Int, days d: Int, weeks w: Int, months M: Int, years y: Int) -> NSDate {
    let comp:NSDateComponents = NSDateComponents()
    comp.second = s
    comp.minute = m
    comp.hour = h
    comp.day = d
    comp.weekOfYear = w
    comp.month = M
    comp.year = y
    return NSCalendar.currentCalendar().dateByAddingComponents(comp, toDate: self, options: [])!
  }
  
  // MARK: - to String
  
  func formattedString(format:String="yyyy-MM-dd_HH-mm") -> String {
    let dateStringFormatter = NSDateFormatter()
    dateStringFormatter.dateFormat = format
    return dateStringFormatter.stringFromDate(self)
  }
  
  // MARK: - before / after
  
  func isBefore(date: NSDate) -> Bool {
    return self.earlierDate(date) == self
  }
  
  func isAfter(date: NSDate) -> Bool {
    return self.laterDate(date) == self
  }
  
  func isBeforeOptional(date: NSDate?, fallBack:Bool) -> Bool {
    if let d = date {
      return self.earlierDate(d) == self
    }
    return fallBack
  }
  
  func isAfterOptional(date: NSDate?, fallBack:Bool) -> Bool {
    if let d = date {
      return self.laterDate(d) == self
    }
    return fallBack
  }
  
  // MARK: - plus / minus
  
  public func plusMinutes(m: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
  }
  
  public func minusMinutes(m: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: -Int(m), hours: 0, days: 0, weeks: 0, months: 0, years: 0)
  }
  
  public func plusHours(h: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: 0, hours: Int(h), days: 0, weeks: 0, months: 0, years: 0)
  }
  
  public func minusHours(h: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: 0, hours: -Int(h), days: 0, weeks: 0, months: 0, years: 0)
  }
  
  public func plusDays(d: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: 0, hours: 0, days: Int(d), weeks: 0, months: 0, years: 0)
  }
  
  public func minusDays(d: Int) -> NSDate {
    return self.addComponents(seconds: 0, minutes: 0, hours: 0, days: -Int(d), weeks: 0, months: 0, years: 0)
  }
  
  public func withoutTime(date:NSDate) -> NSDate {
    return NSCalendar.currentCalendar().dateBySettingHour(0, minute: 0, second: 0, ofDate: self, options: NSCalendarOptions())!
  }
  
  class public func nowWithoutTime() -> NSDate {
    return NSCalendar.currentCalendar().dateBySettingHour(0, minute: 0, second: 0, ofDate: NSDate(), options: NSCalendarOptions())!
  }
}