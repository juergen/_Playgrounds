// Playground - noun: a place where people can play

import UIKit
import Foundation

extension String {
	
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
	
	func leftPad(count:Int, pad:String) -> String {
		if count > countElements(self) {
			return (pad + self).leftPad(count, pad: pad)
		}
		return self
	}
	
}

extension Int {
	func leftPad(count:Int, pad:String) -> String {
		let intAsString = "\(self)"
		if count > countElements(intAsString)  {
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
println("\(testParse.parseDate(pattern))")

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
	"Tue 10\t\t5:48 AM EST / 1.17 ft\t11:43 AM EST / 2.76 ft\t5:56 PM EST / 0.99 ft\t\t\n" +
	"Wed 11\t12:14 AM EST / 2.89 ft\t6:38 AM EST / 1.23 ft\t12:31 PM EST / 2.68 ft\t6:43 PM EST / 1.01 ft\t\tLast Quarter\n" +
	"Thu 12\t1:08 AM EST / 2.91 ft\t7:39 AM EST / 1.26 ft\t1:28 PM EST / 2.62 ft\t7:40 PM EST / 1.00 ft\t\t\n" +
	"Fri 13\t2:11 AM EST / 2.96 ft\t8:48 AM EST / 1.23 ft\t2:34 PM EST / 2.62 ft\t8:45 PM EST / 0.94 ft\t\t\n" +
	"Sat 14\t3:18 AM EST / 3.06 ft\t9:56 AM EST / 1.11 ft\t3:43 PM EST / 2.69 ft\t9:53 PM EST / 0.82 ft\t\t\n" +
	"Sun 15\t4:24 AM EST / 3.21 ft\t10:58 AM EST / 0.94 ft\t4:49 PM EST / 2.83 ft\t10:57 PM EST / 0.65 ft\t\t\n" +
	"Mon 16\t5:26 AM EST / 3.37 ft\t11:55 AM EST / 0.73 ft\t5:49 PM EST / 3.02 ft\t11:58 PM EST / 0.47 ft\t\t\n" +
	"Tue 17\t6:22 AM EST / 3.53 ft\t12:47 PM EST / 0.52 ft\t6:45 PM EST / 3.22 ft\t\t\t\n" +
	"Wed 18\t\t12:55 AM EST / 0.31 ft\t7:15 AM EST / 3.63 ft\t1:36 PM EST / 0.35 ft\t7:39 PM EST / 3.39 ft\tNew Moon\n" +
	"Thu 19\t\t1:50 AM EST / 0.20 ft\t8:06 AM EST / 3.67 ft\t2:24 PM EST / 0.24 ft\t8:30 PM EST / 3.51 ft\t\n" +
	"Fri 20\t\t2:43 AM EST / 0.16 ft\t8:56 AM EST / 3.62 ft\t3:12 PM EST / 0.20 ft\t9:21 PM EST / 3.56 ft\t\n" +
	"Sat 21\t\t3:36 AM EST / 0.21 ft\t9:45 AM EST / 3.50 ft\t3:59 PM EST / 0.23 ft\t10:12 PM EST / 3.53 ft\t\n" +
	"Sun 22\t\t4:30 AM EST / 0.33 ft\t10:36 AM EST / 3.33 ft\t4:48 PM EST / 0.33 ft\t11:06 PM EST / 3.43 ft\t\n" +
	"Mon 23\t\t5:26 AM EST / 0.50 ft\t11:28 AM EST / 3.12 ft\t5:39 PM EST / 0.47 ft\t\t\n" +
	"Tue 24\t12:02 AM EST / 3.29 ft\t6:25 AM EST / 0.70 ft\t12:23 PM EST / 2.91 ft\t6:34 PM EST / 0.64 ft\t\t\n" +
	"Wed 25\t1:03 AM EST / 3.14 ft\t7:29 AM EST / 0.88 ft\t1:24 PM EST / 2.73 ft\t7:34 PM EST / 0.79 ft\t\tFirst Quarter\n" +
	"Thu 26\t2:09 AM EST / 3.01 ft\t8:37 AM EST / 1.01 ft\t2:29 PM EST / 2.62 ft\t8:38 PM EST / 0.90 ft\t\t\n" +
	"Fri 27\t3:18 AM EST / 2.95 ft\t9:44 AM EST / 1.07 ft\t3:36 PM EST / 2.59 ft\t9:43 PM EST / 0.95 ft\t\t\n" +
"Sat 28\t4:23 AM EST / 2.96 ft\t10:45 AM EST / 1.07 ft\t4:38 PM EST / 2.64 ft\t10:43 PM EST / 0.94 ft\t\t"

//println(info)

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

func p(printMe: Any) {
	println("\(printMe)")
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
	//println("\(index) \(line)")
	let elements: [String] = line.split("\t")
	for element in elements {
		print("\(element) | ")
	}
	println("")
	
	var dayString: String = yearMonth
	
	for (index, element) in enumerate(elements) {
		
		switch headers[index] {
			
		case "Day":
			dayString = yearMonth + (element as NSString).substringFromIndex(4)
			
		case "High":
			if let meterPoint = parseTide(dayString, element, Tide.High) {
				checkPoint.meterPoints.append(meterPoint)
			}
			
		case "Low":
			if let meterPoint = parseTide(dayString, element, Tide.Low) {
				checkPoint.meterPoints.append(meterPoint)
			}
			
		case let "Moon":
			checkPoint.meterPoints.last?.moon = Moon(rawValue: element)
			
		default:
			()
		}
	}
}

var checkPoint = Checkpoint()

for (index, line) in enumerate(info.split("\n")) {
	parseLine(checkPoint, line)
}

var previous:MeterPoint?

for (index, meterPoint) in enumerate(checkPoint.meterPoints) {
	if index == 0 {
		println("\(meterPoint.display())")
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
	println("  \(timeDifInfo)  \(levelDif)")
	println("\(meterPoint.display())")
	previous = meterPoint
}
