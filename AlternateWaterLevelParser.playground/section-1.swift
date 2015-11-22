// Playground - noun: a place where people can play

// use DEBUG variable to switch between offline and online debugging

import UIKit
import Foundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(true)

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))

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

let ONLINE = false

if ONLINE {
	print("\n**************** WE ARE ONLINE (see let ONLINE = \(ONLINE)) ****************\n")
} else {
	print("\n**************** WE ARE OFFLINE (see let ONLINE = \(ONLINE)) ****************\n")
}


let demoData =
"\"2015-04-01 00:15\";78,70;Rohdaten\n" +
	"\"2015-04-01 00:30\";80,10;Rohdaten\n" +
	"\"2015-04-01 00:45\";78,70;Rohdaten\n" +
	"\"2015-04-01 01:00\";;Rohdaten\n" +
	"\"2015-04-01 14:15\";80,10;Rohdaten\n" +
	"\"2015-04-01 14:30\";81,60;Rohdaten\n" +
	"\"2015-04-01 14:45\";81,60;Rohdaten\n" +
"\"2015-04-01 15:00\";;Rohdaten\n"

class MeterPoint {
	var level: Float?
	var date: NSDate?
	
	init(level:Float, date:NSDate) {
		self.level = level
		self.date = date
	}
	
	func display() -> String {
		return "MeterPoint: \(date!) \(level!)"
	}
	
}

class Checkpoint {
	var meterPoints: [MeterPoint] = []
}

func parseLine(checkpoint:Checkpoint, line:String) {
	print("will parse: \(line)")
	let elements: [String] = line.split(";")
	if let date = elements[0].parseDate("\"yyyy-MM-dd HH:mm\"") {
		if let value = elements[1].toFloat() {
			checkpoint.meterPoints.append(MeterPoint(level: value, date: date))
		}
	}
}

let predicate: String -> Bool = { $0.startsWith("\"20") || $0.startsWith("\"19") }

func parse(checkPoint: Checkpoint, parseMe: String) {
	
	parseMe.split("\n").filter(predicate).map {parseLine(checkPoint, line: $0)}
	
	for meterpoint in checkpoint.meterPoints {
		print("\(meterpoint.display())")
	}
	
}

var checkpoint: Checkpoint = Checkpoint()

// use next line to debug parser
if !ONLINE {
	parse(checkpoint, parseMe: demoData)
}


// produkt=
// wasserstand
// abfluss

let url = NSURL(string: "http://www.gkd.bayern.de/fluesse/download/index.php?wertart=ezw&beginn=05.04.2015&ende=07.04.2015&msnr=16005701&prbstnr=&thema=gkd&rubrik=fluesse&produkt=abfluss&parameter=&mpnr1=&mpnr2=&dl=Download")
let session = NSURLSession.sharedSession()

let task = session.dataTaskWithURL(url!) {(data, response, error) in
	if let data = NSString(data: data!, encoding: NSUTF8StringEncoding) {
		if let downloadUrl = (data as String).substringBetweenExclude(".innerHTML = 'Bitte <a href=\"", last: "\">hier</a> klicken falls Ihr Download") {
			print("Will download values from: \(downloadUrl)\n")
			let downloadTask = session.dataTaskWithURL(NSURL(string: downloadUrl)!) {(data2, response, error) in
				//println("\(NSString(data: data2, encoding: NSISOLatin1StringEncoding))")
				if let downloadData = NSString(data: data2!, encoding: NSISOLatin1StringEncoding) {
					parse(checkpoint, parseMe: downloadData as String)
				}
			}
			downloadTask.resume()
		}
	}
}

// comment next line to avoid http requests during debugging
if ONLINE {
	task.resume()
}

