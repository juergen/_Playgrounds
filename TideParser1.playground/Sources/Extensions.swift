//
// This file (and all other Swift source files in the Sources directory of this playground) will be precompiled into a framework which is automatically made available to TideParser1.playground.
//

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
  
  func parseDate(_ format:String="yyyy-MM-dd") -> NSDate? {
    var dateFmt = NSDateFormatter()
    dateFmt.timeZone = NSTimeZone.defaultTimeZone() //NSTimeZone.localTimeZone()
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
  
  func substringBetween(first: String, last: String) -> String? {
    if let start = self.rangeOfString(first)?.startIndex {
      if let end = self.rangeOfString(last, options:NSStringCompareOptions.BackwardsSearch)?.endIndex {
        return self.substringWithRange(start ..< end)
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
  
  func substringBefore(before: String) -> String? {
    if let end = self.rangeOfString(before, options:NSStringCompareOptions.BackwardsSearch)?.startIndex {
      return self.substringWithRange(self.startIndex ..< end)
    }
    return nil
  }
  
  func substringAfter(after: String) -> String? {
    if let start = self.rangeOfString(after)?.startIndex {
      return self.substringWithRange(start ..< self.endIndex)
    }
    return nil
  }
  
  func leftPad(c:Int, pad:String) -> String {
    if c > count(self) {
      return (pad + self).leftPad(c, pad: pad)
    }
    return self
  }
  
}

public extension Int {
  func leftPad(c:Int, pad:String) -> String {
    let intAsString = "\(self)"
    if c > count(intAsString)  {
      return (pad + intAsString).leftPad(c, pad: pad)
    }
    return intAsString
  }
}