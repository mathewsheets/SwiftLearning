/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Classes & Structures
*/
/*:
> **Session Overview:**
> The Swift language features that we learned in the previous sessions dealt with simple data types. We learned about 'Int's, 'String's, 'Bool's that allowed us to store values with the correct data type. We can group a small number of data type values together as an atomic unit using tuples and we can store data type values in containers that will enabled us to collect data throughout our programs. Swift also provides us the ability to extend Swift itself by creating custom data types in the form of Classes and Structures. These custom data type in their simplest form are really composite data types, data types that contain other data types.
*/
import Foundation
/*:
## Creating
Creating a class or a structure is done with the keywords `class` and `struct`.
*/
class President {
    
}

struct Term {
    
}
/*:
Above we created a class `President` and a structure `Term`. Right now they don't store data or have behavior. Throughout this session we will build out what a `President` and `Term` can store the behavior it provides.
*/
/*:
## Types vs. Instances
`President` and `Term` are types. There is only 1 in existence throughout your program. We can create many instances of a `President` or `Term`. Remember the simple data types such as `Int` and `String`? There is only 1 `Int` and 1 `String` data type in Swift, but we can create as many instances as `Int` or `String` that we like.
*/
let president = President()

let term = Term()
/*:
Above we have store instances of type `President` and `Term` into constants. We create `President` and `Term` instance using an initializer `()`.
*/
/*:
## Value Types vs. Reference Types
Value types are data types like `Int` and `String`, their values are copied when either assigned to constancts or variables or passed to functions. Reference types are data type like closures, you are assigning or passing a location pointing to a memory space. Structures are *value types*. Classes are *reference types*. The difference is very important.
*/
/*:
## Properties
Properties enable you to store data within the class or structure. Properties are constants or variables tied to the class/structure (data type) or to an instance of the of the class/structure.
*/
class President1 {
    
    static var address = "" // stored type property
    
    let country = "United States of America" // stored instance constant property
    var name = "" // stored instance variable propery
}

struct Term1 {
    
    static let length = 4 // stored type property
    
    var start: NSDate? // stored instance propery
    var end: NSDate? // stored instance propery
}
/*:
Above we created a class `President1` and structure `Term1`, each with a type property and instance properties of constant and variables. Some properties are initialized and some are optional.
*/
/*:
### Instance Stored Properties
`President1` and `Term1` both have instance stored properties. You can change instance stored properties through out your program for that particular instance.
*/
let president1 = President1()

president1.name = "George Washington"

var term1 = Term1()

term1.start = DateUtils.createDate(year: 1789, month: 4, day: 30)
term1.end = DateUtils.createDate(year: 1797, month: 3, day: 4)
/*:
Above we assign the `president1.name`,  `term1.start` and `term1.end` instance stored property.
*/
/*:
### Type Stored Properties
Stored properties that only exist for the class and *not* the instance of a class are type stored properties. You create a type property with the keyword `static`.
*/
President1.address = "1600 Pennsylvania Ave NW, Washington, DC 20500"

let presidentAddress = President1.address

let presidentialLength = Term1.length
/*:
Above we assign the `President1.address` type store property. We are able to do this because it's a variable. The `Term.length` is a constance, therefore we can not assign a new value to it.
*/
//: > **Experiment**: Uncomment below to see what happens.
//president1.country = "South"

//Term1.length = 8

//let term2 = Term1();

//term2.start = nil
/*:
### Lazy Stored Properties
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
print(president2.party.sayThankYou(president2.name!))
/*:
Above we created a `Party` class and a `President2` class which has a stored instance property of type `Party`. `Party` could take a while to initialize. We use the `lazy` keyword to indicate that we want `party` only to be assigned when we access the `party` property of an instance of the `President2` class.
*/
/*:
#### Computed Properties
Swift provides properties that look and act like stored properties, but they don't store anything, they derive values or accept values to be stored in a different way. These types of properties are called computed properties.
*/
class President3 {

    var birthDate: NSDate?
    var deathDate: NSDate?

    var yearsAlive: Int { // computed property with "get", and "set" with custom parameter
        
        get {
            guard birthDate != nil && deathDate != nil else {
                
                return 0
            }
            
            return DateUtils.yearSpan(birthDate!, to: deathDate!)
        }
        
        set(years) {
            guard birthDate != nil else {
                
                return
            }
            
            let dateComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: birthDate!)
            
            deathDate = DateUtils.createDate(year: dateComps.year + years, month: dateComps.month, day: dateComps.day)
        }
    }
    
    var diedHowLongAgo: Int { // Shorthand Setter Declaration, allowed to omit the (parenthesis and custom parameter name)
        
        get {
            
            guard deathDate != nil else {
                
                return 0
            }
            
            return DateUtils.yearSpan(deathDate!, to: NSDate())
        }
        
        set {
            
            let nowComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: NSDate())
            
            deathDate = DateUtils.createDate(year: nowComps.year - newValue, month: nowComps.month, day: nowComps.day - 1) // subtract 1 so we don't end on same date
        }
    }
    
    
    var age: Int { // Read-Only Computed Properties, allowed to omit the "get"
        
        guard birthDate != nil else {
            
            return 0
        }
        
        return DateUtils.yearSpan(birthDate!, to: NSDate())
    }
}

let ronald = President3()
ronald.birthDate = DateUtils.createDate(year: 1911, month: 2, day: 6)

ronald.diedHowLongAgo = 11
print("died \(ronald.diedHowLongAgo) years ago")

print("had \(ronald.yearsAlive) years on earth")

print("if alive he would be \(ronald.age) years old")
/*:
Above we created a `President3` class with stored properties of `birthDate` and `deathDate` and computed properteis of `yearsAlive`, `diedHowLongAgo`, `age`. Notice how the computed properteis act like proxies for the stored properties. Also notice how a computed property can be read-only as well as the shorhand version of the `set` for the `diedHowLongAgo` computed property.
*/
/*:
### Property Observers

*/
class ElectoralVote {
    
    static let houseVotes = 435
    static let senateVotes = 100
    static let dictrictOfColumbisVotes = 3
    static let maxElectoralVotes = houseVotes + senateVotes + dictrictOfColumbisVotes
    static let electoralVotesNeedToWin = maxElectoralVotes / 2
    
    var count: Int = 0 {
        
        willSet {
            print("About to set vote count to \(newValue)")
        }
        didSet {
            print("You had \(oldValue) votes, now you have \(count)")
            
            if ElectoralVote.electoralVotesNeedToWin < count  {
                
                print("You just won the presidency")
            }
        }
    }
}

print("There are a total of \(ElectoralVote.maxElectoralVotes) electoral votes.")
print("You need more than \(ElectoralVote.electoralVotesNeedToWin) electoral votes to win the presidency.")

let electoralVote = ElectoralVote()
electoralVote.count = 100
electoralVote.count = 270
/*:

*/
/*:
## Initializing

*/
class President4 {
    
    var name = "James Madison"
    var state = "Virginia"
    var party = "Democratic-Republican"
}

struct Term4 {
    
    var start: NSDate
    var end: NSDate
}
/*:
### Default Initializer

*/
let president4 = President4()

print(president4.name)
print(president4.state)
print(president4.party)
/*:
### Structures: Memberwise Initializer

*/
let startTerm4 = DateUtils.createDate(year: 2004, month: 11, day: 2)
let endTerm4 = DateUtils.createDate(year: 2008, month: 11, day: 2)

let term4 = Term4(start: startTerm4!, end: endTerm4!)
/*:
## The `self` property and Custom Initializers

*/
class President5 {
    
    var name: String
    var state: String
    var party: String
    
    init(name: String, state: String, party: String) {
        
        self.name = name
        self.state = state
        self.party = party
    }
}

struct Term5 {
    
    var start: NSDate
    var end: NSDate
    
    init(start: NSDate, end: NSDate) {
        
        self.start = start
        self.end = end
    }
    
    init(start: NSDate, years: Int) {
        
        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)
        
        let end = DateUtils.createDate(year: startComps.year + years, month: startComps.month, day: startComps.day)!
        
        self.init(start: start, end: end)
    }
}

let president5 = President5(name: "James Monroe", state: "Virginia", party: "Democratic-Republican")

let term5_1 = Term5(start: DateUtils.createDate(year: 1817, month: 3, day: 4)!, end: DateUtils.createDate(year: 1825, month: 3, day: 4)!)
let term5_2 = Term5(start: DateUtils.createDate(year: 1817, month: 3, day: 4)!, years: 8)

print(term5_1.start)
print(term5_1.end)

print(term5_2.start)
print(term5_2.end)
/*:
## Methods

*/
class President6 {
    
    var firstname: String!
    var lastname: String!
    
    var street: String!
    var city: String!
    var state: String!
    var zip: String!
    
    init(firstname: String, lastname: String) {
        
        self.firstname = firstname
        self.lastname = lastname
    }
    
    func getFullname() -> String {
        
        return firstname + " " + lastname
    }
    
    static func buildFullname(firstname: String, lastname: String) -> String {
        
        var fullname = ""
        
        if(!firstname.isEmpty) {
            
            fullname += firstname
        }
        
        if(!lastname.isEmpty) {
            
            fullname += " "
            fullname += lastname
        }
        
        return fullname
    }
    
    class func buildAddress(street: String, city: String, state: String, zip: String) -> String {
        
        var address = ""
        
        if(!street.isEmpty) {
            
            address += street
            address += ","
        }
        
        if(!city.isEmpty) {
            
            address += "\n"
            address += city
            address += ","
        }
        
        if(!state.isEmpty) {
            
            address += " "
            address += state
        }
        
        if(!zip.isEmpty) {
            
            address += " "
            address += zip
        }
        
        return address
    }
}
/*:
### Instance Methods

*/
let president6 = President6(firstname: "John", lastname: "Adams")

print(president6.getFullname())
/*:
### Type Methods

*/
president6.street = "1600 Pennsylvania Ave NW"
president6.city = "Washington"
president6.state = "DC"
president6.zip = "20500"

let address = President6.buildAddress(president6.street, city: president6.city, state: president6.state, zip: president6.zip)

print("The address of the president is\n\(address)")

let fullname = President6.buildFullname(president6.firstname, lastname: president6.lastname)

print("The name of the president is \(fullname)")
/*:
### Working with Parameters

*/
class President7 {
    
    var name: String!
    var vpName: String!
    
    func setFullname(first firstname: String, last lastname: String) { // shortened external parameter names
        
        name = firstname + " " + lastname
    }
    
    func setVpName(firstname: String, _ lastname: String) { // no external parameter names
        
        vpName = firstname + " " + lastname
    }
}

let president7 = President7()

president7.setFullname(first: "Andrew", last: "Jackson")
president7.setVpName("Martin", "Van Buren")
/*:
### `mutating` value types within instance methods

*/
struct Term7 {
    
    var start: NSDate!
    var end: NSDate!
    
    mutating func setTerm(start: NSDate) {
        
        self.start = start
        
        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)
        
        self.end = DateUtils.createDate(year: startComps.year + 4, month: 3, day: 4)
    }
}

var term7 = Term7(start: DateUtils.createDate(year: 1829, month: 3, day: 4), end: DateUtils.createDate(year: 1833, month: 3, day: 4))

print(term7.start)
print(term7.end)

term7.setTerm(DateUtils.createDate(year: 1833, month: 3, day: 4)!)

print(term7.start)
print(term7.end)
/*:
### `mutating` your`self` in value types within instance methods

*/
struct Term8 {
    
    var start: NSDate!
    var end: NSDate!
    
    mutating func setTerm(start: NSDate) {
        
        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)
        
        self = Term8(start: start, end: DateUtils.createDate(year: startComps.year + 4, month: 3, day: 4))
    }
}

var term8 = Term8(start: DateUtils.createDate(year: 1829, month: 3, day: 4), end: DateUtils.createDate(year: 1833, month: 3, day: 4))

print(term8.start)
print(term8.end)

term8.setTerm(term8.end)

print(term8.start)
print(term8.end)
/*:
## Deinitialization

*/
class President10 {
    
    var name: String
    
    init(name: String) {
        
        print("initializing with \(name)")
        
        self.name = name
    }
    
    deinit {
        
        print("de-initializing president \(name)")
    }
}

var president10: President10?

president10 = President10(name: "John Tyler")
president10 = nil
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
    
    print("The second president of the 19th century \(madison)")
}

presidents[21, 0] = "George W. Bush"

if let bush = presidents[21, 0] {
    
    print("The first president of the 21th century \(bush)")
}
/*:
## Identity Operators for Reference Types

*/
let president10_1_a = President10(name: "John Tyler")

let president10_1_b = president10_1_a

let president10_2_a = President10(name: "John Tyler")

if(president10_1_a === president10_1_b) {
    
    print("referring to same instance")
}

if(president10_2_a !== president10_1_b) {
    
    print("referring to different instance")
}
/*:
**Exercise:** We need to model the set of possible iPhones manufactured. Replace each possible tuple property value with an enumeration that would be appropriate to the current non enumeration value.
*/

/*:
>> **Constraints:**
*/

/*:
**Checkpoint:**
At this point, ...
*/


/*:
**Supporting Chapters:**
- [Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html)
- [Properties](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html)
- [Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html)
- [Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html) ... up to section Class Inheritance and Initialization
- [Deinitialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Deinitialization.html)
- [Subscripts](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
