import Foundation

extension String {
  func spit(separator:String) -> [NSString] {
    return self.componentsSeparatedByString(separator) as [NSString]
  }
  
  func trim() -> String {
    return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
  }
  
  func parseDate(format:String="yyyy-MM-dd") -> NSDate? {
    let dateFmt = NSDateFormatter()
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
  
  func leftPad(count:Int, pad:String) -> String {
    if count > self.characters.count {
      return (pad + self).leftPad(count, pad: pad)
    }
    return self
  }
  
}

extension Int {
  func leftPad(count:Int, pad:String) -> String {
    let intAsString = "\(self)" as String
    if count > intAsString.characters.count  {
      return (pad + intAsString).leftPad(count, pad: pad)
    }
    return intAsString
  }
}
