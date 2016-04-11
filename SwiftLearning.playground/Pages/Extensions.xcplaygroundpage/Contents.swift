/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Extensions
 * callout(Session Overview): ADD
 */
import Foundation
/*:
 ## Creating
 
 */
extension Int {

    // new type & instance computed properties

    // new type & instance methods

    // new initializers

    // new subscripts

    // new nested types

    // protocol conformance
}

/*:
 ## Adding New Properties
 
 */
extension String {
    
    var length: Int {
        
        return self.characters.count
    }
}

let length = "I should be the length of 28".length

/*:
 ## Adding New Methods
 
 */
extension Double {

    func isWholeNumber() -> Bool {
        
        return self % 1 == 0
    }

    func asInt() -> Int {
        
        return Int(self)
    }

    func remainder() -> Double {

        return self % 1
    }
}

let pi = 3.14159
let piRemainder = pi.remainder()
let piIsWhole = pi.isWholeNumber()
let piInt = pi.asInt()

/*:
 ### Mutation on Value Types
 
 */
extension Int {

    mutating func add(double: Double) {
        
        self = self + double.asInt()
    }
}

var addTo = 1
let adding = 1.5

addTo.add(adding)

/*:
 ## Adding New Initializers
 
 */
extension Int {

    init(numbers: Int ...) {

        var total = 0
        for number in numbers {

            total += number
        }

        self = total
    }
}

let added = Int(numbers: 1, 2, 3, 4, 5, 6, 7, 8, 9)

/*:
 ## Adding Subscripts
 
 */
extension String {

    subscript(start: Int, add: Int) -> String? {
        guard start >= 0 && start < (length - 1) && add >= 0 else {
            return nil
        }
        
        var addTo = add
        if add == Int.max {
            addTo = Int.max - 1 - start
        }

        var end = start + (addTo - 1)
        
        if (end > (length - 1)) {
            end = length - 1
        }

        return substringWithRange(startIndex.advancedBy(start)...startIndex.advancedBy(end))
    }
}

let test = "This is a test of the emergency broadcast system"
let emergency = test[22, 9]
let invalid = test[42, Int.max]

/*:
 ## Adding Nested Types
 
 */
extension Int {
    
    enum Grade {
        case A
        case B
        case C
        case D
        case F
    }

    var grade: Grade {
        
        switch self {
        case 90...100:
            return .A
        case 80..<90:
            return .B
        case 70..<80:
            return .C
        case 60..<70:
            return .D
        default:
            return .F
        }
    }
}

let grade92 = 92.grade
let grade77 = 77.grade
/*:
 ## Conforming to a Protocol with an Extension
 
 */
class Crawler {
    
    var age: Int
    
    init(age: Int) {
        
        self.age = age
    }
}

protocol Crawlable {
    
    func walkable() -> Bool
}

extension Crawler: Crawlable {
    
    func walkable() -> Bool {
        
        if age >= 2 {
            return true
        }
        
        return false
    }
}

/*:
 ## Protocol Adoption with an Extension
 
 */
protocol Walkable: Crawlable {
    
    var direction: String { get set }
    
    func runnable() -> Bool
}

class Walker: Crawler {

    var direction: String

    init(age: Int, direction: String) {

        self.direction = direction

        super.init(age: age)
    }

    func runnable() -> Bool {

        if age >= 5 {
            return true
        }

        return false
    }
}

extension Walker: Walkable {}

/*:
 ## Protocol Extensions
 
 */
/*:
 ### Default Implementations for Protocols
 
 */
protocol Runnable: Walkable {

    var distance: Double {get set}

    func run(speed: Float)
}

class Runner: Walker, Runnable {

    var distance: Double = 0
}

extension Runnable {
    
    func run(speed: Float) {
        
        print("running \(speed) mph \(direction)")
    }
}

/*:
 ### Constraining your Protocol Extension 
 
 */
extension Array where Element: Runnable {

    func totalDistance() -> Double {
        
        var total = 0.0
        
        map { total += $0.distance }
        
        return total
    }
}

/*:
 - - -
 * callout(Exercise): ADD
 
 **Constraints:**
 - ADD
 
 * callout(Checkpoint): At this point, ...
 
 **Keywords to remember:**
 - `extension` = ADD
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)
 - [Guide: Protocols & Conformance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID277)
 - [Guide: Protocols & Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID521)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
