// Playground - noun: a place where people can play

// use DEBUG variable to switch between offline and online debugging

import UIKit
import Foundation
import XCPlayground

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

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
		if let idx = find(self, char) {
			return distance(self.startIndex, idx) == 0
		}
		return false
	}
	
	var length: Int {
		get {
			return countElements(self)
		}
	}
	
	func indexOf(target: String) -> Int {
		var range = self.rangeOfString(target)
		if let range = range {
			return distance(self.startIndex, range.startIndex)
		} else {
			return -1
		}
	}
	
	func indexOf(target: String, startIndex: Int) -> Int {
		var startRange = advance(self.startIndex, startIndex)
		var range = self.rangeOfString(target, options: NSStringCompareOptions.LiteralSearch, range: Range<String.Index>(start: startRange, end: self.endIndex))
		if let range = range {
			return distance(self.startIndex, range.startIndex)
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
		let start = advance(self.startIndex, range.startIndex)
		let end = advance(self.startIndex, range.endIndex)
		return self.substringWithRange(start..<end)
	}
	
	func parseDate(_ format:String="yyyy-MM-dd") -> NSDate? {
		var dateFmt = NSDateFormatter()
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

let ONLINE = true

if ONLINE {
	println("\n**************** WE ARE ONLINE ****************\n")
} else {
	println("\n**************** WE ARE OFFLINE ****************\n")
}


let demoData =
"\"2015-04-01 00:15\";78,70;Rohdaten\n" +
	"\"2015-04-01 00:30\";80,10;Rohdaten\n" +
	"\"2015-04-01 00:45\";78,70;Rohdaten\n" +
	"\"2015-04-01 01:00\";;Rohdaten\n" +
	"\"2015-04-01 01:15\";80,10;Rohdaten\n" +
	"\"2015-04-01 01:30\";81,60;Rohdaten\n" +
	"\"2015-04-01 01:45\";81,60;Rohdaten\n" +
"\"2015-04-01 02:00\";;Rohdaten\n"

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
	println("will parse: \(line)")
	let elements: [String] = line.split(";")
	if let date = elements[0].parseDate("\"yyyy-MM-dd hh:mm\"") {
		if let value = elements[1].toFloat() {
			checkpoint.meterPoints.append(MeterPoint(level: value, date: date))
		}
	}
}

let predicate: String -> Bool = { $0.startsWith("\"20") || $0.startsWith("\"19") }

func parse(checkPoint: Checkpoint, parseMe: String) {
	
	filter(parseMe.split("\n"), predicate).map {parseLine(checkPoint, $0)}
	
	for meterpoint in checkpoint.meterPoints {
		println("\(meterpoint.display())")
	}
	
}

var checkpoint: Checkpoint = Checkpoint()

// use next line to debug parser
if !ONLINE {
	parse(checkpoint, demoData)
}


// produkt=
// wasserstand
// abfluss

let url = NSURL(string: "http://www.gkd.bayern.de/fluesse/download/index.php?wertart=ezw&beginn=06.04.2015&ende=07.04.2015&msnr=16005701&prbstnr=&thema=gkd&rubrik=fluesse&produkt=abfluss&parameter=&mpnr1=&mpnr2=&dl=Download")
let session = NSURLSession.sharedSession()

let task = session.dataTaskWithURL(url!) {(data, response, error) in
	if let data = NSString(data: data, encoding: NSUTF8StringEncoding) {
		if let downloadUrl = (data as String).substringBetweenExclude(".innerHTML = 'Bitte <a href=\"", last: "\">hier</a> klicken falls Ihr Download") {
			println("Will download values from: \(downloadUrl)\n")
			let downloadTask = session.dataTaskWithURL(NSURL(string: downloadUrl)!) {(data2, response, error) in
				//println("\(NSString(data: data2, encoding: NSISOLatin1StringEncoding))")
				if let downloadData = NSString(data: data2, encoding: NSISOLatin1StringEncoding) {
					parse(checkpoint, downloadData)
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

