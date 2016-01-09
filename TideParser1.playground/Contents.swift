// 
// Tide Parser with Sources (Extensions, Functions, Domains etc.)
//

import UIKit
import Foundation

// set default timezone
NSTimeZone.setDefaultTimeZone(NSTimeZone(forSecondsFromGMT: +0))

let yearMonth: String = "2016-02-"
let testParse = yearMonth + "1 6:29 AM"
let pattern = "yyyy-MM-dd h:mm a"
print("\(testParse.parseDate(pattern))")

//for (index, line) in info.split("\n").enumerate() {
//  parseLine(eleutheraWestCost, line: line)
//}

var eleutheraWestCost = Checkpoint()
print("Eleuthera Tide Table February, 2016, 25.2500° N, 76.3167° W (West coast)")
westFeb2016.forEach {
  parseLine(yearMonth, pattern: pattern, checkpoint: eleutheraWestCost, line: $0)
  // print($0.split("\t").count, $0)
}
printCheckpoint(eleutheraWestCost)

print("\n\n")

var eleutheraEastCost = Checkpoint()
print("Eleuthera Tide Table February, 2016, 24.9333° N, 76.1500° W (East coast)")
eastFeb2016.forEach {
  parseLine(yearMonth, pattern: pattern, checkpoint: eleutheraEastCost, line: $0)
  // print($0.split("\t").count, $0)
}
printCheckpoint(eleutheraEastCost)