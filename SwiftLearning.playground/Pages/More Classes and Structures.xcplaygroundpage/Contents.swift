/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# More Classes & Structures
*/
import Foundation
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
print(president2.party.sayThankYou(president2.name!))
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
    
    print("The second president of the 19th century \(madison)")
}

presidents[21, 0] = "George W. Bush"

if let bush = presidents[21, 0] {
    
    print("The first president of the 21th century \(bush)")
}
/*:

*/
/*:
## Convenient Initializing

*/
/*:

*/
/*:
## Optional Chaining

*/
/*:

*/
/*:
### When to use it

*/
/*:

*/
/*:
### Used with Properties

*/
/*:

*/
/*:
### Used with Methods

*/
/*:

*/
/*:
## I'm strong, now I'm weak

*/
/*:

*/
/*:
## Type Casting

*/
/*:

*/
/*:
### Checking Type

*/
/*:

*/
/*:
### Downcasting

*/
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
- `weak` =
- `unowned` =
- `is` =
- `as` =
*/
/*:
**Supporting Chapters:**
- [Subscripts](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Subscripts.html)
- [Initialization](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html)
- [Optional Chaining](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/OptionalChaining.html)
- [ARC](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html)
- [Type Casting](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
