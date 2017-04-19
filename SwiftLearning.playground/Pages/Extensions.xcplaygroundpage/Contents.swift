/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Extensions
 * callout(Session Overview): Extensions provide the capability of adding new functionality to existing types. The existing types include types provided to you either by [The Swift Standard Library](https://developer.apple.com/library/ios/documentation/General/Reference/SwiftStandardLibraryReference/index.html) such as `Int` or `String`, types from a third party framework, or custom types authored by you. In the [Inheritance](Inheritance) session we learned that inheritance gives you the capability of reusing code that is generic across all subtypes and subtypes can override a superclass’s properties or methods. Extensions are similar in that they allow for sharing of code, but the key difference is that extensions cannot override existing properties or methods. The Swift Standard Library uses extensions extensively.
 - - -
 */
import Foundation
/*:
 ## Creating
 Extensions are created with the `extension` keyword. The type that you are extending must exist and be visible for you to create the extension. With extensions, you can:
 - add new type & instance computed properties
 - add new type & instance methods
 - add new initializers
 - add new subscripts
 - add new nested types
 - specify protocol conformance
 */
//: - note: Extensions *cannot* add stored properties or property observers, only **computed** properties. Both stored & computed properties can be accessed within an extension.
/*:
 - example: Extending the `Int` type.\
 This example creates an extension of the `Int` type. You are allowed to creates as many extensions as you like on the same type.
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
 Extensions allow you to add new type and instance computed properties, not stored properties or property observers. The syntax is exactly like creating a computed property in the original type. All existing stored and computed properties, methods and subscripts are available for you to use in the extension. You can also use the `self` keyword to explicitly indicate that you are referencing the instance of the type you are extending.
 - example: Extending the `String` type.\
 This example creates an extension for `String` and adds an instance computed property `length`. The `length` property accesses the `characters` property which accesses the `count` property to return the number of characters in the string.
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
 - example: Extending the `Double` type.\
 Below is an extension on a `Double`. Have have added three methods, all of which use the `self` keyword to reference the current instance.
 */
extension Double {
    
    func isWholeNumber() -> Bool {

        return remainder() == 0
    }
    
    func asInt() -> Int {
        
        return Int(self)
    }
    
    func remainder() -> Double {

        return truncatingRemainder(dividingBy: 1)
    }
}

let pi = 3.14159
let piIsWhole = pi.isWholeNumber()
let piRemainder = pi.remainder()
let piInt = pi.asInt()
/*:
 ### Mutation on Value Types
 If you created an extension on a value type such as a enumeration or structure, you can mutate the instance by using the `mutating` keyword, just like you would have on the original type.
 - example: An extension that mutates a value type.\
 This example is another extension on `Int`, adding a method that mutates the actual instance. Doing so requires the keyword `mutating`.
 */
extension Int {
    
    mutating func add(double: Double) {
        
        self = self + double.asInt()
    }
}

var addTo = 1
let adding = 1.5

addTo.add(double: adding)
/*:
 ## Adding New Initializers
 Extensions allow you to create new initializers for you to provide other ways to initialize a type.
 - note: When you are extending a class, you are only allowed to provide convenience initializers. You are still able to delegate the initialization to another convenience initializer or designated initializer implemented in the original class.
 - example: Extension on `Int` to add a new initializer.\
 This example creates an extension on `Int` adding a new initializer, accepting a variadic parameters of `Int` types. The initializer sums all the `Int` numbers and sets the result to `self`.
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
 - example: Extension adding a convenience initializer on a class.\
 Below is an example of adding a convenience initializer in an extension for the type `Head`. Since `Head` is a class, the initializer is a convenience initializer, not a designated initializer.
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
 - experiment: Delete the `convenience` keyword from the extension `Head`. What does the compiler tell you?
 */
/*:
 ## Adding Subscripts
 Extensions allow you to add new subscripts to existing types. Remember that subscripts enable you to access or mutate elements in a collection type. You can create subscripts as shortcuts for interacting with a type that contains a collection type internally and provide other subscript methods to interact with that internal collection type.
 - example: Extension on `String` adding subscripts.\
 Below we have added two new subscript methods; one to get a `Character` with subscript, and the other to get a substring with a start and end subscripts.
 */
extension String {
    
    subscript(index: Int) -> Character? {
        
        // let's guard against invalid values
        guard index >= 0 && index < length else {
            return nil
        }
        
        return Character(substring(with: self.index(startIndex, offsetBy: index)..<self.index(startIndex, offsetBy: index + 1)))
    }
    
    subscript(start: Int, add: Int) -> String? {
        
        // let's guard against invalid values
        guard start >= 0 && start < length && add >= 0 else {
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
        
        return substring(with: self.index(startIndex, offsetBy: start)..<self.index(startIndex, offsetBy: end + 1))
    }
}

let test = "This is a test of the emergency broadcast system"

let emergency = test[22, 9]
let system = test[42, Int.max]

for var i in 0..<system!.length {
    
    print(system![i]!)
    
    i += 1
}
/*:
 ## Adding Nested Types
 Extensions give you the ability of adding nested types within other type. This could be useful to further expand on the static nature of the type your extending.
 - example: Extension adding a nested type to `Int`.\
 Below is an extension on `Int` adding a nested enumeration `Grade` and an instance computed property `grade`. An instance of `Int` can access the property `grade` to get the appropriate grade enumeration.
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
 Extensions are very useful in breaking up responsibilities of a type into different code blocks or even files. If a type is conforming to a protocol, the implementation of the protocol can be placed in the extension directly. You can even create an extension with the type conforming to a protocol and implement the protocol all in the same extension.
 - example: Extension to add protocol conformance.\
 Below we have a `Crawler` class and a `Crawlable` protocol. Before extensions, we specified protocol conformance within the class definition. But with extensions, we can specify protocol conformance and provide the implementaton within an extension.
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
 If a type already conforms to a protocol without specifying so, you can create an extension only to indicate that the type conforms to the protocol.
 - example: Adopting a protocol with an extension.\
 Class `Walker` implicitly conforms to the `Walkable` protocol. To indicate protocol adoption, a simple 1 line extension will satisfy the protocol requirements.
 */
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

protocol Walkable: Crawlable {
    
    var direction: String { get set }
    
    func runnable() -> Bool
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
 Protocol extensions are an impressive feature of the Swift programming language. With extensions applied to protocols, protocols can be extended to provide the implementation of what is defined in the protocol. Think of it as the default implementation of the protocol that the conforming type can leverage.
 - note: Remember, extensions cannot override functionality, only provide new functionality. Also, if the conforming type also provides the implementation, the implementation in the protocol extension *will not* be use.
 - example: Default implementation of a protocol.\
 Below we leverage protocol extensions by providing the default implementation of the `func run(speed: Float)` method on the `Runnable` protocol.
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

extension Runnable {
    
    func runfast() {
        
        run(speed: 13.8)
    }
}

class Runner: Walker, Runnable {
    
    var distance: Double = 0
}

let runner: Runnable = Runner(age: 16, direction: "North")

runner.run(speed: 6.5)
runner.runfast()
/*:
 ### Constraining your Protocol Extension
 With protocol extensions, you can constrain the protocol extension to only make available the properties and methods to specific conforming types. This allows you to create a protocol extension and indicate what conforming types are allowed to receive the default implementation. You add constraints to a protocol extension with the `where` keyword after the type your are extending. The clause of the `where` is what you are constraining the protocol extension to.
 - example: Protocol extension constraints.\
 Below we are extending the `Array` collection type adding a method `func totalDistance() -> Double`. The `func totalDistance() -> Double` is only available when the array is storing instances of types conforming to the `Runnable` protocol.
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
 - experiment: Create a few `Walker` instances, store them in an array and see if the `totalDistance()` method is available.
 */
/*:
 - - -
 * callout(Checkpoint): At this point, you have seen the power of extensions. Extensions allow you to add new functionally by the means of adding new type/instance computed properties, type/instance methods, initializers and subscripts to existing types that you authored or external to your program. You can also create protocol extensions, allowing you to provide default implementations for conforming types and even constrain the protocol extension to specific types.
 
 **Keywords to remember:**
 - `extension` = The creation of an extension
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Extensions.html)
 - [Guide: Protocols & Conformance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID277)
 - [Guide: Protocols & Extensions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID521)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
