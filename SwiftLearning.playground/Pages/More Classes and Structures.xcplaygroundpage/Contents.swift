/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # More Classes & Structures
 * callout(Session Overview): Last session we learned about the main features of classes and structures. This session explains other features of classes and structures that you will leverage to make your programs more useable and readable.
*/
import Foundation
/*:
## Convenient Initializing
Initializers are used to initialize your class/structure. The special `init` method is used as the initializer and should be defined with parameters that will initialize your stored properties. Swift provides a way to declare another type of initializer that could be more *convenient*. These `convenience` initializers must *delegate* to another `convenience` initializer or to a custom initializer.
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
        
        self.init(firstName: "", lastName: "", party: "", age: 0) // delegate to init
//        self.init(firstName: "", lastName: "") // delegate to another convenience init
    }
}

var none = President()
var abe = President(firstName: "Abraham", lastName: "Lincoln")
/*:
Above we created a `class` President that has 1 initializer defined to initialize all the stored properties and 2 `convenience` initializers to give the option to create an instance of a President with just first and last names or with no values.
*/
/*:
## Failable Initializers
 When implementing custom initializers, it may be appropriate to fail the initialization. You can indicate that an initializer can fail with a `init?` initializer. Then within the initializer, you return `nil` and the result of the stored instance will be `nil`.
*/
class PresidentFailable {

    var age: Int

    init?(age: String) {
        if let ageNum = Int(age) {
            self.age = ageNum
        } else {
            return nil
        }
    }
}

if let failable = PresidentFailable(age: "fifty") {
    print("The president is \(failable.age)")
} else {
    print("prez didn't get initialized")
}
/*:
 Above we created a `PresidentFailable` class that has a failable initializer. We create an instance of `PresidentFailable` and by leveraging `if let` optional binding, and print a string of the president’s age.
 */
/*:
## Optional Chaining
You will create programs that have properties that have not been initialized. This means that you need to check if the property does have a value and then access the properties or call methods on that property. Optional chaining provides you the ability to access or call methods of a property contained in a class/structure without having to check for `nil`.
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
Above we have defined a structure `Term` and class `President1`. `President1` has an optional property `term` of type `Term`.
*/
/*:
### When to use it
Below we have the typical way in which we would check to see if we can get the date range of President Kennedy's term, by checking if `term` in not `nil`.
*/
let kennedy = President1(firstName: "John", lastName: "Kennedy")
if kennedy.term != nil {

    let range = kennedy.term!.dateRange()
    print("President Kennedy's term was \(range)")
}
/*:
### Used with Properties
Optional chaining lets us access a potential `nil` property, and access properties *potentially* down a chain of properties.
*/
if let termStart = kennedy.term?.start, let termEnd = kennedy.term?.end {  // combining option binding in one `if`

    print("President Kennedy's term was \(termStart) - \(termEnd)")
}
/*:
Above we leverage optional chaining, by using the question mark symbol directly after the property that could be `nil`, to access properties of that instance. We only print the date range if both `termStart` and `termEnd` are not `nil`.
*/
/*:
### Used with Methods
We can also use optional chaining to call methods on a potentially `nil` property.
*/
if let termRange = kennedy.term?.dateRange() {

    print("President Kennedy's term was \(termRange)")
}
/*:
Above we call the `dateRange()` method on an instance of the property `term` (an instance of class `Term`). If `term` is `nil`, the `dateRange()` method is never called and with the rules of option binding, the print statement is not executed.
*/
/*:
## `mutating` value types within instance methods
Properties within value types in Swift (Enumerations & Structures) cannot be modified from within instance methods. You can change this behavior by placing the `mutating` keyword in front of the method name indicating that the method will mutate (change property values) the current instance.
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
Above we created a `Term2` structure that defines a mutating instance method `setTerm`, that accepts a date as an argument but also changes the property values of `start` and `end`.
*/
/*:
## `mutating` your`self` in value types within instance methods
`mutating` instance methods can even change what `self` refers to.
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
Above we created another structure, `Term3` with a mutating instance method `setTerm`, that accepts a date as an argument, but this time the implicit self property is assigned an entirely new instance.
*/
/*:
## Lazy Stored Properties
Classes and structures are very similar to other data types. Therefore you can have properties that are of a class or structure type. There are times when it makes sense to initialize a class or structure whenever you access the property and not durning the initialization of the container class. We can do this lazy initializing with the `lazy` keyword.
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
Subscripts within classes/structures provide a shorthand way to access/mutate member elements of collection types that your class/structure stores.
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
Above we created a `Presidents` class that has a property that stores presidents by the century in which they started their presidency. We also define a `subscript` method accepting as arguments, century and number, both `Int`s and returning a `String`. We provide both the `get` and `set` subscript methods to access and mutate the `presidentsByCentury` property.
*/
/*:
## `strong`, `weak`, `unowned`, oh my!
Swift provides three types of reference types. We have already worked with the `strong` reference type; it's the default reference type when assigning an instance of a reference type to a constant/variable. The other two `weak` and `unowned` are used to prevent *strong reference cycles* within your instance.
*/
class President3 {

    var name: String
    var whiteHouse: WhiteHouse?
    var term: Term4?

    init(name: String) {
        
        self.name = name
    }
    
    deinit {
        
        print("bye bye president")
    }
}

class Term4 {

    weak var president: President3? // Term4 holds a weak reference to President3. weak indicates that president could be nil

    init(president: President3) {
        
        self.president = president
    }
    
    deinit {
        
        print("bye bye term")
    }
}

class WhiteHouse {
    
    unowned var president: President3 // WhiteHouse holds an unowned reference to President3. unowned indicates that president will never be nil
    
    init(president: President3) {
        
        self.president = president
    }
    
    deinit {
        
        print("bye bye whitehouse")
    }
}

var roosevelt: President3? = President3(name: "Theodore Roosevelt")
roosevelt!.whiteHouse = WhiteHouse(president: roosevelt!)
roosevelt!.term = Term4(president: roosevelt!)
roosevelt = nil
/*:
Above we created `President3`, `Term4`, and `WhiteHouse` classes. `President3` stores an instance of `WhiteHouse` and `Term4`. `Term4` stores an instance to `President3` and `WhiteHouse` stores an instance 'President3'. Without `weak` and `unowned`, the `deinit`s would never be called therefore creating a memory leak.
*/
/*:
## Identity Operators for Reference Types
Identity operators are used to determine if two instances of the same class refer to the same location in memory; they are in fact the same instance. Identity operators for reference types are `===` three equal symbols or `!==` exclamation point and two equal symbols. This is not to be confussed with equatable operators `==` and `!=`, explained in [Protocols](Protocols), which typically compare the actual property values in each instance.
*/
let president10_1_a = President(firstName: "John", lastName: "Tyler")
let president10_2_a = President(firstName: "John", lastName: "Tyler")

let president10_1_b = president10_1_a

if(president10_1_a === president10_1_b) {
    
    print("referring to same instance")
}

if(president10_2_a !== president10_1_b) {
    
    print("referring to different instance")
}
/*:
Above we have two instances of the `President` class, both with the same first and last name. We assign the first `President` instance to another constant and compare if they are the exact same instance. The second instance is compared to the first to prove that they are not the same instance.
*/
/*:
## Control access with `public`, `internal`, `private`
Swift provides three ways to control what is visible to other classes. The `public` keyword marks the class/member visible outside the module. The `internal` keyword marks the class/member visible only to inside the module. The `private` keyword marks the class/member visible to only the class itself. The default access is `internal`. You need to explicitly set a class/member to `public` for the class/member to be visible outside the module. Access control can be applied to properties, function, custom types and their properties and methods.
*/
public class Congress {             // explicitly public class
    
    public var members: [String]?   // explicitly public variable
    var date: NSDate?               // implicitly internal variable
    private var leader: String?     // explicitly private variable
}

class Senate {                      // implicitly internal class

    internal var members: [String]? // explicitly internal variable
    private var leader: String?     // explicitly private variable
}

private class SenateMember {        // explicitly private class

    var firstName: String?          // implicitly private variable
    var lastName: String?           // implicitly private variable
    
    private func name() -> String { // explicitly private method
    
        return "\(firstName) \(lastName)"
    }
}
/*:
Above we have created 3 classes showing what control access rules are allowed to set and what is explicitly and implicitly applied.
*/
/*:
 - - -
 * callout(Exercise): Build upon your `Dog` and `Cat` classes in the previous exercise by applying the appropriate access control for each class/structure member. Add a `Owner` class that contains a collection of `Dog` instances and `Cat` instances. Have your `Dog` and `Cat` hold the correct reference type to an `Owner` instance. The `Ower` property of the `Cat` instance reference is optional. Provide a `subscript` to interact with your `Dog` and `Cat` instances.
 
 **Constraints:**
 - Use `weak`
 - Use `unowned`
 - Use `subscript`
 - Create a `convenience` initializer for creating your `Dog` and `Cat` instance
 * callout(Checkpoint): At this point, we learned about other features that classes/structures support such as lazy initialization of properties and subscripts to interact with classes/structures in a collection type way. We also learned about how you can change property values in value types within the instance as well as testing if two instances are identical. Finally we learned how to avoid memory leaks by using the correct reference type and how to leverage the access controls for properties, functions, classes and class members.
 
 **Keywords to remember:**
 - `convenience` = define an initializer that delegates the initialization to other initializers
 - `lazy` = define a stored property to be initialized when the property is first accessed
 - `subscript` = provide the ability to access/mutate a class/structure with subscripts as in `[5]`
 - `mutating` = allowing a value type instance method to change properties within the instance
 - `weak` = defining a optional stored property as storing a weak reference to avoid *strong reference cycles*
 - `unowned` = defining a non optional stored property as storing an unowned reference to avoid *strong reference cycles*
 - `public` = marks the class/member visible outside the module
 - `internal` = marks the class/member visible only to inside a module
 - `private` = marks the class/member visible to only the class
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Subscripts](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html)
 - [Guide: Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
 - [Guide: Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)
 - [Guide: ARC](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html)
 - [Guide: Access Control](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
