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
Properties enable you to store data within a class or structure. Properties are constants or variables tied to the class/structure (data type) or to an instance of the class/structure.
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
Above we created a class `President1` and structure `Term1`, each with a type property and instance properties of a constant and variables. Some properties are initialized and some are optional.
*/
/*:
### Instance Stored Properties
`President1` and `Term1` both have instance stored properties. You can change instance stored properties through out your program for that particular instance.
*/
let president1 = President1()

president1.name = "George Washington"

//president1 = President1()

var term1 = Term1()

term1.start = DateUtils.createDate(year: 1789, month: 4, day: 30)
term1.end = DateUtils.createDate(year: 1797, month: 3, day: 4)
/*:
Above we assign the `president1.name`, `term1.start` and `term1.end` instance stored property.
*/
/*:
### Type Stored Properties
Stored properties that only exist for the class/structure and *not* the instance of a class/structure are type stored properties. You create a type property with the keyword `static`.
*/
President1.address = "1600 Pennsylvania Ave NW, Washington, DC 20500"

let presidentAddress = President1.address

let presidentialLength = Term1.length
/*:
Above we assign the `President1.address` type store property. We are able to do this because it's a variable. The `Term.length` is a constant, therefore we can not assign a new value to it.
*/
//: > **Experiment**: Uncomment below to see what happens.
//president1.country = "South"

//Term1.length = 8

//let term2 = Term1();

//term2.start = nil
/*:
#### Computed Properties
Swift provides properties that look and act like stored properties, but they don't store anything; they derive values or accept values to be stored in a different way. These types of properties are called *computed properties*.
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
        
        set { // no custom parameter
            
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
Above we created a `President3` class with stored properties of `birthDate` and `deathDate` and computed properties of `yearsAlive`, `diedHowLongAgo`, and `age`. Notice how the computed properteis act like proxies for the stored properties. Also notice how a computed property can be read-only as well as the shorhand version of the `set` for the `diedHowLongAgo` computed property.
*/
/*:
### Property Observers
Swift provides the abiliy to observe changes to properties when values change. The `willSet` method is called just before the property value is set and the `didSet` is called just after the property value is set.
*/
class ElectoralVote {
    
    static let houseVotes = 435
    static let senateVotes = 100
    static let dictrictOfColumbiaVotes = 3
    static let maxElectoralVotes = houseVotes + senateVotes + dictrictOfColumbiaVotes
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
Above we have a stored property `count` that is using the property observers of `willSet` and `didSet`. `willSet` provides the special `newValue` variable of *what* the property will change to. `didSet` provides both a `oldValue` ad `newValue` variables after the property as been changed.
*/
/*:
## Initializing
Initializers on classes and structures are specials methods that initialize the class or structure.
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
Both classes and structures data types have default initializers.
*/
let president4 = President4()

print(president4.name)
print(president4.state)
print(president4.party)
/*:
Above we create a new instance of class `President4` by using the default initializer.
*/
/*:
### Structures: Memberwise Initializer
Swift automatically provides structures an initializer with parameters for every variable stored property.
*/
let startTerm4 = DateUtils.createDate(year: 2004, month: 11, day: 2)
let endTerm4 = DateUtils.createDate(year: 2008, month: 11, day: 2)

let term4 = Term4(start: startTerm4!, end: endTerm4!)
/*:
Above we create a new instance of structure `Term4` by using the initializer memberwise initializer.
*/
/*:
## The `self` property and Custom Initializers
Custom initializers are initializers created by you for the purpose of supplying values to a class/structure. You use the argument values of the initializer to set properties. If the argument names are the same as the property names, you can use `self` to distinguish between the class/structure and the argument. One important note on custom initializers is that all non-optional stored properties must be initialized.
*/
class President5 {
    
    var name: String
    var state: String
    var party: String
    
    init(name: String, state: String, party: String) { // initializer to set values using "self"
        
        self.name = name
        self.state = state
        self.party = party
    }
}

struct Term5 {
    
    var start: NSDate
    var end: NSDate
    
    init(start: NSDate, end: NSDate) { // you can have multiple initializers
        
        self.start = start
        self.end = end
    }
    
    init(start: NSDate, years: Int) {
        
        let startComps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: start)
        
        let end = DateUtils.createDate(year: startComps.year + years, month: startComps.month, day: startComps.day)!
        
        self.init(start: start, end: end) // allowed to call another initialize and need to initialize all non-optional stored properties
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
Above we have class `President5` and structure `Term5`, both with custom initializer using `self` inside the initializer.
*/
/*:
## Methods
Methods give you the abiliy to provide behavior to your class/structure. Methods are just like functions, but are tied the class/structure and are able to access properties within the class/structure.
*/
class President6 {
    
    var firstname: String!
    var lastname: String!
    
    var street: String!
    var city: String!
    var state: String!
    var zip: String!
    
    // custom initializer
    
    init(firstname: String, lastname: String) {
        
        self.firstname = firstname
        self.lastname = lastname
    }
    
    // instance method
    
    func getFullname() -> String {
        
        return firstname + " " + lastname
    }
    
    // type method
    
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
    
    // type method that can be overridden by a subclass... inheritance not cover yet
    
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
`President6` has 1 instance method. It has access to instance properties.
*/
let president6 = President6(firstname: "John", lastname: "Adams")

print(president6.getFullname())
/*:
Above we assign an instance of `President6` to a constant and print the return of the instance method `getFullname()`
*/
/*:
### Type Methods
`President6` has 2 type methods. Type methods do not have access to instance properties. You use the name of the class/structure then the method name to call a type method
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
Above we call `buildAddress` and `buildFullname` type methods of class `President6` passing in arguments from instance properties.
*/
/*:
### Working with Parameters
Remember that methods are really functions but tied to either a class/structure or an instance of a class/structure and therefore have access to properties. One important note, type properties don't have access to instance properties, but instance properties can access type properties.
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

*/
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
- `class` = 
- `struct` =
- `static` = `class`
- `get` =
- `set` =
- `willSet` =
- `didSet` =
- `init` =
- `self` =
- `deinit` =
*/
/*:
**Supporting Chapters:**
- [Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html)
- [Properties](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html)
- [Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html)
- [Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html) ... up to section Class Inheritance and Initialization
- [Deinitialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Deinitialization.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
