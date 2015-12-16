import Foundation

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