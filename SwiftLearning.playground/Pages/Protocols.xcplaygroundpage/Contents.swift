/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Protocols
 * callout(Session Overview): In the context of the English language, a protocol is a set of rules that explain the conduct and procedures to be followed. You can also think of it as a contract between two parties and consequences if the contract is broken. In the context of typed programming languages, a protocol defines what must be implemented by a data type, with a compiler responding with errors if you don’t follow the protocol.
 */
import Foundation
/*:
 ## What Are They and Why Use Them?
 Swift protocols are essentially types without the implementation of properties or methods. They create a contract with a conforming type. The conforming type must implement the properties and methods defined in the protocol.
 
 As we have learned in earlier sessions, types can contain other types, as well as creating collection of types. When applying that to protocol, you as the developer are unaware of the implementation, you only care that a property or method exists for you to access or call. This single attribute of protocols, not being aware of the implementation, gives you the ability to change the implementation or have multiple implementations of a protocol. This provides you with low coupling between two data types and a pluggable application architecture.
 */
/*:
 ## Conforming To
 In earlier session, we have already encountered protocols. Most of the data types we have worked with such as `Int`, `String` and `Bool` all **conform** to one of the following three protocols, `Equatable`, `Comparable`, and `Hashable`. Conforming to a `protocol` implies that the data type provides the implementation of the properties or methods defined in the `protocol`.
 */
/*:
 ### `Equatable`
 By conforming to the `Equatable` protocol, you are implying that your data type will implement `public func ==(lhs: Self, rhs: Self) -> Bool` and that instances of that type can be compared for value equality using operators `==` and `!=`
 */
class Father: Equatable {

    var name: String
    var age: Int

    init(name: String, age: Int) {
        
        self.name = name
        self.age = age
    }
}

// it's an operator, the implementation must be defined globally

func ==(lhs: Father, rhs: Father) -> Bool {
    
    return lhs.name == rhs.name && lhs.age == rhs.age
}

let moe1 = Father(name: "Moe", age: 28)
let moe2 = Father(name: "Moe", age: 28)
let curly = Father(name: "Curly", age: 50)

if moe1 == moe2 {
    print("same moe")
} else {
    print("not the same moe")
}

if moe1 === moe2 {
    print("same moe identity")
} else {
    print("not the same moe identity")
}

if moe1 == curly {
    print("same father")
} else {
    print("not the same father")
}
/*:
 
 */
/*:
 ### `Comparable`
 By conforming to the `Comparable` protocol, you are implying that your data type will implement:
 - `public func <(lhs: Self, rhs: Self) -> Bool`
 - `public func <=(lhs: Self, rhs: Self) -> Bool`
 - `public func >=(lhs: Self, rhs: Self) -> Bool`
 - `public func >(lhs: Self, rhs: Self) -> Bool`
 */
class Son: Father, Comparable {

    var favoriteTruck: String

    init(name: String, age: Int, truck: String) {

        favoriteTruck = truck

        super.init(name: name, age: age)
    }
}

func <(lhs: Son, rhs: Son) -> Bool {
    
    return lhs.age < rhs.age
}

func <=(lhs: Son, rhs: Son) -> Bool {
    
    return lhs.age <= rhs.age
}

func >=(lhs: Son, rhs: Son) -> Bool {
 
    return lhs.age >= rhs.age
}

func >(lhs: Son, rhs: Son) -> Bool {
    
    return lhs.age > rhs.age
}

let larry2 = Son(name: "Larry", age: 2, truck: "Blue Dump")
let larry4 = Son(name: "Larry", age: 4, truck: "Blue Dump")
let larry7 = Son(name: "Larry", age: 7, truck: "Blue Dump")
let larry10 = Son(name: "Larry", age: 10, truck: "Blue Dump")

if larry2 < larry4 {
    
    print("larry 2 < larry 4")
}

if larry4 <= larry4 {
    
    print("larry 4 <= larry 4")
}

if larry7 >= larry4 {
    
    print("larry 7 >= larry 4")
}

if larry10 > larry7 {
    
    print("larry 10 >= larry 7")
}
/*:
 
 */
/*:
 ### `Hashable`
 By conforming to the `Hashable` protocol, you are implying that your data type will implement `public var hashValue: Int { get }` and that instances of that type can be as `Dictionary` keys.
 */
class Daughter: Father, Hashable {
    
    var favoriteDoll: String
    
    var hashValue: Int {
        
        return "\(name),\(age),\(favoriteDoll)".hashValue
    }
    
    init(name: String, age: Int, doll: String) {
        
        favoriteDoll = doll
        
        super.init(name: name, age: age)
    }
}

let abby1 = Daughter(name: "abby", age: 3, doll: "Barbie")
let abby2 = Daughter(name: "abby", age: 3, doll: "Barbie")

let katie = Daughter(name: "katie", age: 5, doll: "Cabbage Patch")

if abby1.hashValue == abby2.hashValue {
    print("same hashValue")
} else {
    print("different hashValue")
}

if abby1.hashValue == katie.hashValue {
    print("same hashValue")
} else {
    print("different hashValue")
}

var fathersByDaughter: [Daughter:Father] = [:]

fathersByDaughter[abby1] = moe1

print(fathersByDaughter[abby1]!.name)

fathersByDaughter[abby2] = curly

print(fathersByDaughter[abby1]!.name)

fathersByDaughter[katie] = curly

if fathersByDaughter[abby2] == fathersByDaughter[katie] {
    
    print("abby2 and katie have the same father")
}
/*:
 
 */
/*:
 ## Creating Protocols
 Protocols are created with the `protocol` keyword. The properties and methods definitions of the `protocol` must be implemented by the conforming data type.
 */
protocol Crawlable {

    // type & instance properties to conform to

    // type & instance methods to conform to
}

class Crawler: Crawlable {

}

let crawler = Crawler()
/*:
 
 */
/*:
 ## Protocols & Properties
 Protocols can define both type and instance properties. The conforming data type property could be either a stored or computed property, as long as the name and type are correct. When defining a property in a `protocol`, you need to specify what property methods need to be implemented with the `get` and/or `set` property methods.
 */
protocol Walkable: Crawlable {
    
    var direction: String { get set }
}

class Walker: Walkable {
    
    var direction: String
    
    init(direction: String) {
        
        self.direction = direction
    }
}

let walker = Walker(direction: "North")

print(walker.direction)
/*:
 
 */
/*:
 ## Protocols & Methods
 Protocols can define both type and instance methods. Again, conforming data types need to implement the defined type or instance protocol method.
 */
protocol Runnable: Walkable {

    func run(speed: Float)
}

class Runner: Runnable {

    var direction: String

    init(direction: String) {

        self.direction = direction
    }

    func run(speed: Float) {

        print("running \(speed) mph \(direction)")
    }
}

let runner = Runner(direction: "West")

runner.run(6.5)
/*:
 
 */
/*:
 ## Protocols & Initializers
 Protocols can also defined initializers. In doing so, the conforming data type is required to implement the initializer. The `required` keyword must be included in the conforming data type’s implementation of the initializer.
 */
protocol Talkable {
    
    init(son: Son)
}

class TalkingSon: Son, Talkable {

    required init(son: Son) {

        super.init(name: son.name, age: son.age, truck: son.favoriteTruck)
    }

    var description: String {

        return "My name is \(name). I'm \(age) years old and my favorite truck is \(favoriteTruck)"
    }
}

let talker = TalkingSon(son: Son(name: "Oliver", age: 2, truck: "Red"))

print(talker.description)
/*:
 
 */
/*:
 ## Protocols as Types
 With `protocol`s and `class`es, the properties and methods defined in the `protocol` and the properties and methods implemented in the conforming `class` appear to be one in the same. Remember, `protocol`s don’t provide the implementation, but classes do. You cannot create an instance of just a `protocol`, you must create an instance of a concrete data type that conforms to a `protocol`. This enables you do store, return, and pass as arguments to functions, data types confirming to a `protocol` with just the `protocol` name.
 */
var crawers: [Crawlable] = [] // an array of Crawlable instances. Crawlable is a protocol

let walkable: Walkable? // an instance of Walkable

class RunnerWalker: Runnable {

    let walker: Walkable

    var direction: String

    init(walker: Walkable, direction: String) { // initializer with a protocol parameter

        self.walker = walker
        self.direction = direction
    }

    func run(speed: Float) {

        print("I can run \(speed) mph")
    }
}
/*:
 
 */
/*:
 ## Delegating the work with Protocols
 In the world of iOS development, the delegation design pattern is leveraged all through out the SDK. The delegation design pattern enables concrete classes to delegate work to other data types that conform to a `protocol`. The `protocol` is responsible to define what work that needs to be executed and conforming data types implement the work. The concrete data type that does the delegation does not need to know the underlining implementation of the `protocol`
 ### The Protocols
 Protocols are what make the delegation design pattern powerful. We don't want our concrete classes coupled to a another concrete class.
 */
protocol DoableAction {

    var action: String { get }
}

protocol DoableActionDelegate {

    func willDo(what: DoableAction)
    func doing(what: DoableAction)
    func didDo(what: DoableAction)
}

protocol Doable {

    func doingWhat()
}
/*:
 ### The Comforming Types
 We need classes to conform to the above protocols to swap out implementations.
 */
class NothingAction: DoableAction {
    var action: String {
        return "Nothing"
    }
}
class EatingAction: DoableAction {
    var action: String {
        return "Eating"
    }
}
class DrinkingAction: DoableAction {
    var action: String {
        return "Drinking"
    }
}
class SleepingAction: DoableAction {
    var action: String {
        return "Sleeping"
    }
}
class BusyWorkAction: DoableAction {
    var action: String {
        return "Busy Work"
    }
}

class DoingSomethingPrinter: DoableActionDelegate {

    func willDo(what: DoableAction) {

        print("will do \(what.action)")
    }

    func doing(what: DoableAction) {

        print("doing \(what.action)")
    }

    func didDo(what: DoableAction) {

        print("did do \(what.action)")
    }
}

class DoingSomethingTimeTracker: DoableActionDelegate {
    
    func willDo(what: DoableAction) {
        
        print("will track time of doing \(what.action)")
    }
    
    func doing(what: DoableAction) {
        
        print("track time of doing \(what.action)")
    }
    
    func didDo(what: DoableAction) {
        
        print("did track time of doing \(what.action)")
    }
}

class DoingSomething: Doable {

    var action: DoableAction = NothingAction()
    var delegate: DoableActionDelegate?

    func doingWhat() {

        delegate?.willDo(action)

        delegate?.doing(action)

        delegate?.didDo(action)
    }
}
/*:
 ### Bringing it all together
 When leveraging the delegation design pattern, we can swap out the implementation of the of the protocol providing different behavior.
 */
let worker = DoingSomething()
worker.delegate = DoingSomethingPrinter() // let's just print what the worker is doing
worker.doingWhat()

worker.action = EatingAction()
worker.doingWhat()

worker.action = DrinkingAction()
worker.doingWhat()

worker.action = SleepingAction()
worker.doingWhat()

worker.action = BusyWorkAction()
worker.delegate = DoingSomethingTimeTracker() // pretend that this will actually persist somewhere
worker.doingWhat()
/*:

 */
/*:
 ## Type Checking & Type Casting Protocols
 As we learned in the [Inheritance](Inheritance) session, we can leverage the type check operator `is` and the type cast operator `as` when checking if a data type is a subclass of a superclass. The same applies to `protocol`s, because `protocol`s  represent an instance of a concrete class.

 */
if talker is Crawlable { // this is false
    print("I'm a crawler")
}

if let aTalker = crawler as? Talkable { // this is false
    print("I'm a talker")
}

var objects: [AnyObject] = []

objects.append(crawler)  // conforms to Crawlable
objects.append(walker)   // conforms to Walkable
objects.append(runner)   // conforms to Runnable
objects.append(talker)   // conforms to Talkable
objects.append(worker)   // conforms to Doable

for object in objects {
    switch object {
    case let crawler as Crawlable:
        print("I'm a Crawlable")
    case let crawler as Walker:
        print("I'm a Walker")
    case let crawler as Runner:
        print("I'm a Runner")
    case let talker as Talkable:
        print("I'm a Talkable")
    case let worker as Doable:
        print("I'm a Doable")
    default:
        print("I'm something strange")
    }
}
/*:
 
 */
/*:
 - - -
 * callout(Exercise): Leveraging protocols and the delegation design pattern, your task is to build a simple bank teller system. The teller’s job responsibilities are to open, credit, debit savings and checking accounts. The teller is not sure what really happens when they perform their responsibilities, it just works.
 
 **Constraints:**
 - Create an audit delegate that tracks when an account is opened, credited and debited
 - Create a protocol for which a savings and checking accounts need to conform
 - Create a teller class with customers and accounts
 - Perform the teller's responsibilities

 * callout(Checkpoint): At this point, you have learned how to leverage and see the power of protocols. Protocols and the delegation design pattern enable you to build data type low coupling relationships. Protocols provide the capability to swap out the underlying implementation without suffering the consequence of compiler errors if you had coupled to a concrete class.
 
 **Keywords to remember:**
 - `protocol` = The declaration of a protocol
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Protocols](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
 - [Video: Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015-408/)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
