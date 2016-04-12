/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Extensions
 * callout(Session Overview): Extensions provide the capability of adding new functionality to existing types. The existing types include types provided to you either by [The Swift Standard Library](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html) such as `Int` or `String`, types from a  third party framework, or custom types authored by you. In the [Inheritance](Inheritance) session we learned that Inheritance gives you the capability of reusing code that is generic across all subtypes and subtypes can override a superclass’s properties or methods. Extensions are similar in that they allow for sharing of code, but the key difference is that extensions cannot override existing properties or methods. The Swift Standard Library uses extensions extensively.
 */
import Foundation
/*:
 ## Creating
 Extensions are created with the `extension` keyword. The type that you are extending must exist and be visible for you to create the extension. With extensions, you can:
 - add new type & instance computed properties
 - new type & instance methods
 - new initializers
 - new subscripts
 - new nested types
 - protocol conformance
 - note: Extensions *cannot* add stored properties or property observers, **only computed** properties. Both stored & computed properties can be access within an extension.
 - example: Extending the `Int` type.
 This example creates an extension of the `Int` type. You are allowed to creates as many extension as you like on the same type.
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
 Extensions allow you to add new type and instance computed properties, not stored properties or property observers. The syntax is exactly like creating a computed property in the original type.  All existing stored and computed properties, methods and subscripts are available for you to use in the extension. You can also use the `self` keyword to explicitly indicate that you are referencing the instance of the type you are extending.
 - example: ADD
 */
extension String {
    
    var length: Int {
        
        return characters.count
    }
}

let length = "I should be the length of 28".length

/*:
 ## Adding New Methods
 In similar fashion as adding new computed properties, you add new methods to an existing type by creating an extension and add the new methods. You are not able to override properties and methods.
 - example: ADD
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
let piIsWhole = pi.isWholeNumber()
let piRemainder = pi.remainder()
let piInt = pi.asInt()
/*:
 ### Mutation on Value Types
 If you created an extension on a value type such as a enumeration or structure, you can mutate the instance by using the `mutating` keyword`, just like you would have on the original type.
 - example: ADD
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
 Extensions allow you to create new initializers for you to provide other ways to initialize a type.
 - note: When you are extending a class, you are only allowed to provide convenience initializers. You are still able to delegate the initialization to another convenience initializer or designated initializer implemented in the original class.
 - example: ADD
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
 - example: ADD
 */
class Head {
    
    var eyes: Int
    
    init(eyes: Int) {
        self.eyes = eyes
    }
}

extension Head {
    
    convenience init() {
        
        self.init(eyes: 2)
    }
}
/*:
 ## Adding Subscripts
 
 - example: ADD
 */
extension String {

    subscript(start: Int, add: Int) -> String? {
        
        // let's guard against invalid values
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
 
 - example: ADD
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
 
 - example: ADD
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

let crawler: Crawlable = Crawler(age: 3)
if crawler.walkable() {
    print("able to walk")
} else {
    print("unable to walk")
}
/*:
 ## Protocol Adoption with an Extension
 
 - example: ADD
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

let walker: Walkable = Walker(age: 7, direction: "North")

if walker.runnable() {
    print("able to run")
} else {
    print("unable to run")
}
/*:
 ## Protocol Extensions

 */
/*:
 ### Default Implementations for Protocols
 
 - example: ADD
 */
protocol Runnable: Walkable {

    var distance: Double {get set}

    func run(speed: Float)
}

extension Runnable {
    
    func run(speed: Float) {
        
        print("running \(speed) mph \(direction)")
    }
}

class Runner: Walker, Runnable {
    
    var distance: Double = 0
}

let runner: Runnable = Runner(age: 16, direction: "North")

runner.run(6.5)
/*:
 ### Constraining your Protocol Extension 
 
 - example: ADD
 */
extension Array where Element: Runnable {

    func totalDistance() -> Double {
        
        var total = 0.0
        
        map { total += $0.distance }
        
        return total
    }
}

var runner1 = Runner(age: 16, direction: "North")
runner1.distance = 3.0
var runner2 = Runner(age: 17, direction: "South")
runner2.distance = 5.0
var runner3 = Runner(age: 18, direction: "East")
runner3.distance = 2.0
var runner4 = Runner(age: 19, direction: "West")
runner4.distance = 6.0

var runners: [Runner] = []

runners.append(runner1)
runners.append(runner2)
runners.append(runner3)
runners.append(runner4)

let runningDistance = runners.totalDistance()

print("the total distance of \(runners.count) runners is \(runningDistance)")
/*:
 - - -
 * callout(Exercise): ADD
 
 **Constraints:**
 - ADD
 
 * callout(Checkpoint): At this point, ...
 
 **Keywords to remember:**
 - `extension` = The creation of an extension
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)
 - [Guide: Protocols & Conformance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID277)
 - [Guide: Protocols & Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID521)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
