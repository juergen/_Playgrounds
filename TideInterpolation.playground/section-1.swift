// Playground - noun: a place where people can play

import UIKit
import Foundation
import Darwin // for pi
import XCPlayground
let pi = M_PI

extension String {
	
//	func split(separator:String) -> [NSString] {
//		return self.componentsSeparatedByString(separator) as [NSString]
//	}
	
	func split(separator:String) -> [String] {
		return self.componentsSeparatedByString(separator) as [String]
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
		let intAsString = "\(self)"
		if count > intAsString.characters.count  {
			return (pad + intAsString).leftPad(count, pad: pad)
		}
		return intAsString
	}
}

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))

let yearMonth: String = "2015-02-"
let testParse = yearMonth + "1 6:29 AM"
let pattern = "yyyy-MM-dd h:mm a"
//println("\(testParse.parseDate(pattern))")

// Day	High	Low	High	Low	High	Moon
let header: String = "Day\tHigh\tLow\tHigh\tLow\tHigh\tMoon"

let headers: [String]  = header.split("\t")

let info: String =
"Sun 1\t6:29 AM EST / 3.11 ft\t12:50 PM EST / 0.77 ft\t6:41 PM EST / 2.69 ft\t\t\t\n" +
	"Mon 2\t\t12:42 AM EST / 0.66 ft\t7:11 AM EST / 3.14 ft\t1:30 PM EST / 0.74 ft\t7:23 PM EST / 2.77 ft\t\n" +
	"Tue 3\t\t1:24 AM EST / 0.66 ft\t7:48 AM EST / 3.16 ft\t2:07 PM EST / 0.73 ft\t8:01 PM EST / 2.83 ft\tFull Moon\n" +
	"Wed 4\t\t2:03 AM EST / 0.68 ft\t8:22 AM EST / 3.15 ft\t2:40 PM EST / 0.74 ft\t8:37 PM EST / 2.87 ft\t\n" +
	"Thu 5\t\t2:41 AM EST / 0.73 ft\t8:54 AM EST / 3.12 ft\t3:12 PM EST / 0.77 ft\t9:11 PM EST / 2.89 ft\t\n" +
	"Fri 6\t\t3:16 AM EST / 0.80 ft\t9:25 AM EST / 3.07 ft\t3:43 PM EST / 0.81 ft\t9:44 PM EST / 2.90 ft\t\n" +
	"Sat 7\t\t3:51 AM EST / 0.89 ft\t9:56 AM EST / 3.00 ft\t4:13 PM EST / 0.86 ft\t10:17 PM EST / 2.90 ft\t\n" +
	"Sun 8\t\t4:27 AM EST / 0.98 ft\t10:28 AM EST / 2.92 ft\t4:43 PM EST / 0.91 ft\t10:51 PM EST / 2.89 ft\t\n" +
	"Mon 9\t\t5:05 AM EST / 1.08 ft\t11:03 AM EST / 2.84 ft\t5:17 PM EST / 0.96 ft\t11:29 PM EST / 2.89 ft\t\n" +
	"Tue 10\t\t5:48 AM EST / 1.17 ft\t11:43 AM EST / 2.76 ft\t5:56 PM EST / 0.99 ft\t\t"

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

class MeterPoint : CustomStringConvertible {
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
        return description;
	}
    var description: String {
        return "\(date!) \(level!) \(tide!.rawValue) " + (moon?.rawValue ?? "")
    }
}

class Checkpoint {
	var meterPoints: [MeterPoint] = []
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



func parseLine(checkpoint:Checkpoint, line:String) {
	let elements: [String] = line.split("\t")
	
	var dayString: String = yearMonth
	
	for (index, element) in elements.enumerate() {
		
		switch headers[index] {
			
		case "Day":
			dayString = yearMonth + (element as NSString).substringFromIndex(4)
			
		case "High":
			if let meterPoint = parseTide(dayString, timeAndTide: element, tide: Tide.High) {
				checkPoint.meterPoints.append(meterPoint)
			}
			
		case "Low":
			if let meterPoint = parseTide(dayString, timeAndTide: element, tide: Tide.Low) {
				checkPoint.meterPoints.append(meterPoint)
			}
			
		case "Moon":
			checkPoint.meterPoints.last?.moon = Moon(rawValue: element)
			
		default:
			()
		}
	}
}

var checkPoint = Checkpoint()

for (index, line) in (info.split("\n")).enumerate() {
	parseLine(checkPoint, line: line)
}

var previous:MeterPoint?

for (index, meterPoint) in checkPoint.meterPoints.enumerate() {
	if index == 0 {
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
	previous = meterPoint
}



func interpolatedHeight(d : NSDate, tideData: Checkpoint) -> Float? {
    let tidesFiltered = { (predicate : (NSTimeInterval -> Bool)) -> [MeterPoint] in
        tideData.meterPoints.filter({(meterPoint: MeterPoint) -> Bool in
            if let dt = meterPoint.date?.timeIntervalSinceDate(d) {
                return predicate(dt)
            } else {
                return false
            }
        })
    }
    
    let tidesSortedByAbsTimeDiffToReferenceDate = {
        (referenceDate: NSDate, tideList : [MeterPoint]) -> [MeterPoint] in
        tideList.sort( { (m0: MeterPoint, m1: MeterPoint) -> Bool in
                let dt0 = abs(m0.date!.timeIntervalSinceDate(referenceDate))
                let dt1 = abs(m1.date!.timeIntervalSinceDate(referenceDate))
                return  dt0 < dt1
            })
    }
    
    // 14 hours time difference to select high/low tide near given dateTime d for any tide types
    let timeDiff_nearTides : NSTimeInterval = 14 * 3600
    let tidesBefore : [MeterPoint] = tidesFiltered({-$0 >= 0 && -$0 < timeDiff_nearTides})
    let tidesBeforeSorted = tidesSortedByAbsTimeDiffToReferenceDate(d, tidesBefore)
    
    let tidesAfter = tidesFiltered({$0 > 0 && $0 < timeDiff_nearTides})
    let tidesAfterSorted = tidesSortedByAbsTimeDiffToReferenceDate(d, tidesAfter)
    
    if let tideBefore = tidesBeforeSorted.first {
        if let tideAfter = tidesAfterSorted.first {
            let height_before = tideBefore.level!
            let height_after = tideAfter.level!
            
            let height_average : Float  = (height_before + height_after)/2
            let height_diff = (height_before - height_after)
            
            let dt_beforeToAfter : Double = tideAfter.date!.timeIntervalSinceDate(tideBefore.date!)
            let dt_beforeToNow : Double = d.timeIntervalSinceDate(tideBefore.date!)
            
            let height_interpolated : Float = height_average+0.5*height_diff*Float(cos(dt_beforeToNow/dt_beforeToAfter*pi))
    
            return height_interpolated
      }
    }
    
    print("error: Not enough data in meterPoints of checkPoint \(tideData) to interpolate tide at date \(d)")
    return nil
}

func print_tides() {
    checkPoint.meterPoints.map({ print($0.description) })
}


print_tides()
var d = "2015-02-05 18:03".parseDate("yyyy-MM-dd HH:mm")
print("height: for date \(d!): \(interpolatedHeight(d!, tideData: checkPoint))")

let startDate = "2015-02-05 18:03".parseDate("yyyy-MM-dd HH:mm")

for var dt_hours: Double = 0; dt_hours<93; dt_hours+=1 {
  let value = interpolatedHeight(startDate!.dateByAddingTimeInterval(dt_hours*3600.0), tideData: checkPoint)!
  XCPlaygroundPage.currentPage.captureValue(value, withIdentifier:"h")
}

