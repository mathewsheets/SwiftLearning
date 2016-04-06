/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Protocols
 * callout(Session Overview): ADD
 */
import Foundation
/*:
 ## What Are They and Why Use Them?
 */
/*:
 ## Conforming To
 */

/*:

 */
/*:
 ### Equatable
 */
class Father: Equatable {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        
        self.name = name
        self.age = age
    }
}

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
 ### Comparable
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
 ### Hashable
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
 
 */
var crawers: [Crawlable] = []

let walkable: Walkable?

class RunnerWalker: Runnable {

    let walker: Walkable

    var direction: String

    init(walker: Walkable, direction: String) {

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
 
 */
/*:
 ### The Protocols
 */
protocol DoableAction {

    var action: String { get set }
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
 ### Comforming Types
 */
class DoSomething: DoableAction {
    
    var doAction: String
    
    var action: String {
        get {
            return doAction
        }
        set {
            doAction = newValue
        }
    }
    
    init(doAction: String) {
        
        self.doAction = doAction
    }
}

class DoSomethingPrinter: DoableActionDelegate {

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

class DoSomethingTimeTracker: DoableActionDelegate {
    
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

    var action: DoableAction = DoSomething(doAction: "Nothing")
    var delegate: DoableActionDelegate?

    func doingWhat() {

        delegate?.willDo(action)

        delegate?.doing(action)

        delegate?.didDo(action)
    }
}
/*:
 ### Bringing it all together
 */
let worker = DoingSomething()
worker.delegate = DoSomethingPrinter() // let's just print what the worker is doing
worker.doingWhat()

worker.action = DoSomething(doAction: "Eating")
worker.doingWhat()

worker.action = DoSomething(doAction: "Drinking")
worker.doingWhat()

worker.action = DoSomething(doAction: "Sleeping")
worker.doingWhat()

worker.action = DoSomething(doAction: "Busy Work")
worker.delegate = DoSomethingTimeTracker() // pretend that this will actually persist somewhere
worker.doingWhat()
/*:
 
 */
/*:
 ## Type Checking & Type Casting Protocols
 
 */
var objects: [AnyObject] = []

objects.append(crawler)  // conforms to Crawlable
objects.append(walker)   // conforms to Walkable
objects.append(runner)   // conforms to Runnable
objects.append(talker)   // conforms to Talkable
objects.append(worker)   // conforms to Doable

for object in objects {
    switch object {
    case let crawler as Runner:
        print("I'm a Runner")
    case let crawler as Walker:
        print("I'm a Walker")
    case let crawler as Crawlable:
        print("I'm a Crawlable")
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
 * callout(Exercise): ADD
 
 **Constraints:**
 - ADD

 * callout(Checkpoint): ADD
 
 **Keywords to remember:**
 - `protocol` =
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Protocols](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
 - [Video: Protocol-Oriented Programming in Swift](https://developer.apple.com/videos/play/wwdc2015-408/)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
