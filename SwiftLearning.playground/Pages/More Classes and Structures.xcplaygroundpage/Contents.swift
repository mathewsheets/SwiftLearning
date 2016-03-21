/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# More Classes & Structures
*/
/*:
> **Session Overview:**
> NEED
*/
import Foundation
/*:
## Convenient Initializing

*/
class President {
    
    var firstName: String
    var lastName: String
    var party: String
    var age: Int

    init(firstName: String, lastName: String, party: String, age: Int) {

        self.firstName = firstName
        self.lastName = lastName
        self.party = party
        self.age = age
    }

    convenience init(firstName: String, lastName: String) {

        self.init(firstName: firstName, lastName: lastName, party: "Not Affiliated", age: 0)
    }
    
    convenience init() {
        
        self.init(firstName: "", lastName: "", party: "", age: 0)
//        self.init(firstName: "", lastName: "")
    }
}

var none = President()
var abe = President(firstName: "Abraham", lastName: "Lincoln")
/*:

*/
/*:
## Optional Chaining

*/
struct Term {

    var start: NSDate
    var end: NSDate

    func dateRange() -> String {

        return "\(DateUtils.dateStringFrom(start)) - \(DateUtils.dateStringFrom(end))"
    }
}

class President1 {
    
    var firstName: String
    var lastName: String
    
    var term: Term?
    
    init(firstName: String, lastName: String) {
        
        self.firstName = firstName
        self.lastName = lastName
    }
}
/*:

*/
/*:
### When to use it

*/
let kennedy = President1(firstName: "John", lastName: "Kennedy")
if kennedy.term != nil {

    let range = kennedy.term!.dateRange()
    print("President Kennedy's term was \(range)")
}
/*:

*/
/*:
### Used with Properties

*/
if let termStart = kennedy.term?.start, let termEnd = kennedy.term?.end {

    print("President Kennedy's term was \(termStart) - \(termEnd)")
}
/*:

*/
/*:
### Used with Methods

*/
if let termRange = kennedy.term?.dateRange() {

    print("President Kennedy's term was \(termRange)")
}
/*:

*/
/*:
## `mutating` value types within instance methods

*/
struct Term2 {

    var start: NSDate!
    var end: NSDate!

    mutating func setTerm(start: NSDate) {

        self.start = start

        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)

        self.end = DateUtils.createDate(year: startComps.year + 4, month: 3, day: 4)
    }
}

var term2 = Term2(start: DateUtils.createDate(year: 1829, month: 3, day: 4), end: DateUtils.createDate(year: 1833, month: 3, day: 4))

print(term2.start)
print(term2.end)

term2.setTerm(DateUtils.createDate(year: 1833, month: 3, day: 4)!)

print(term2.start)
print(term2.end)
/*:

*/
/*:
## `mutating` your`self` in value types within instance methods

*/
struct Term3 {
    
    var start: NSDate!
    var end: NSDate!
    
    mutating func setTerm(start: NSDate) {
        
        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)
        
        self = Term3(start: start, end: DateUtils.createDate(year: startComps.year + 4, month: 3, day: 4))
    }
}

var term3 = Term3(start: DateUtils.createDate(year: 1829, month: 3, day: 4), end: DateUtils.createDate(year: 1833, month: 3, day: 4))

print(term3.start)
print(term3.end)

term3.setTerm(term3.end)

print(term3.start)
print(term3.end)
/*:

*/
/*:
## Lazy Stored Properties
Classes and structures are very similar to other data types. Therefore you can have properties that are of a class or structure. There are times when it makes sense to initialize a class or structure whenever you access the property and not durning the initialization of the container class. We can do this lazy initializing with the `lazy` keyword.
*/
class Party {
    
    var members = [String]()
    
    func sayThankYou(president: String) {
        
        for member in members {
            
            print("Thank you \(member), your president \(president)")
        }
    }
    
    init() { // initialization explained below
        
        print("Party initialzed")
        
        members.append("Matt")
        members.append("Annie")
        members.append("Samuel")
        members.append("Jack")
        members.append("Hudson")
        members.append("Oliver")
    }
}

class President2 {
    
    lazy var party = Party()
    
    var name: String?
}

let president2 = President2()
president2.name = "John Adams"

print(president2.name!)
print(president2.party.members)
president2.party.sayThankYou(president2.name!)
/*:
Above we created a `Party` class and a `President2` class which has a stored instance property of type `Party`. `Party` could take a while to initialize. We use the `lazy` keyword to indicate that we want `party` only to be assigned when we access the `party` property of an instance of the `President2` class.
*/
/*:
## Subscripts

*/
class Presidents {
    
    var presidentsByCentury = [Int: [String]]()
    
    init () {
        
        presidentsByCentury[18] = getPresidentsByCentury(18)
        presidentsByCentury[19] = getPresidentsByCentury(19)
        presidentsByCentury[20] = getPresidentsByCentury(20)
        presidentsByCentury[21] = getPresidentsByCentury(21)
    }
    
    subscript(century: Int, number: Int) -> String? {
        
        get {
            let presidents = presidentsByCentury[century]
            
            return presidents![number]
        }
        
        set {
            var presidents = presidentsByCentury[century]
            
            presidents![number] = newValue!
            
            presidentsByCentury[century] = presidents
        }
    }
}

let presidents = Presidents()

if let madison = presidents[19, 1] {
    
    print("The second president of the 19th century was \(madison)")
}

presidents[21, 0] = "George W. Bush"

if let bush = presidents[21, 0] {
    
    print("The first president of the 21th century was \(bush)")
}
/*:

*/
/*:
## `strong`, `weak`, `unowned`, oh my!

*/
class President3 {

    var name: String
    var whiteHouse: WhiteHouse?
    var term: Term4?

    init(name: String) {
        
        self.name = name
    }
}

struct Term4 {

    weak var president: President3? // Term4 holds a weak reference to President3

    init(president: President3) {
        
        self.president = president
    }
}

class WhiteHouse {
    
    unowned var president: President3 // WhiteHouse holds an unowned reference to President3
    
    init(president: President3) {
        
        self.president = president
    }
}

let roosevelt = President3(name: "Theodore Roosevelt")
let whiteHouse = WhiteHouse(president: roosevelt)
let term = Term4(president: roosevelt)
/*:

*/
/*:
## Identity Operators for Reference Types

*/
let president10_1_a = President(firstName: "John", lastName: "Tyler")

let president10_1_b = president10_1_a

let president10_2_a = President(firstName: "John", lastName: "Tyler")

if(president10_1_a === president10_1_b) {
    
    print("referring to same instance")
}

if(president10_2_a !== president10_1_b) {
    
    print("referring to different instance")
}
/*:

*/
/*:
**Exercise:**
*/

/*:
>> **Constraints:**
*/

/*:
**Checkpoint:**
At this point, ...
*/

/*:
**Keywords to remember:**
- `convenience` =
- `lazy` =
- `subscript` =
- `mutating` =
- `weak` =
- `unowned` =
*/
/*:
**Supporting Chapters:**
- [Subscripts](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html)
- [Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
- [Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)
- [ARC](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html)

*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
