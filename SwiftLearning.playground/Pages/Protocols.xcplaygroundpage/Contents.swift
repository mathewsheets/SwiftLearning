/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Protocols
 * callout(Session Overview): ADD
 */
import Foundation
/*:
 ## What Is It?
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
    
    var name: String?
    var age: Int?
}

func ==(lhs: Father, rhs: Father) -> Bool {
    
    return lhs.name == rhs.name && lhs.age == rhs.age
}



/*:
 
 */
/*:
 ### Comparable
 */
class Son: Father, Comparable {
    
    var favoriteTruck: String?
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
/*:
 
 */
/*:
 ### Hashable
 */
class Daughter: Father, Hashable {
    
    var favoriteDoll: String?
    
    var hashValue: Int {
        
        return "\(name),\(age),\(favoriteDoll)".hashValue
    }
}
/*:
 
 */
/*:
 ## Creating
 
 */
/*:
 
 */
/*:
 ## Protocols & Properties
 
 */
/*:
 
 */
/*:
 ## Protocols & Methods
 
 */
/*:
 
 */
/*:
 ## Protocols & Initializers
 
 */
/*:
 
 */
/*:
 ## Protocols as Types
 
 */
/*:
 
 */
/*:
 ## Delegating the work
 
 */
/*:
 
 */
/*:
 ## Type Checking & Type Casting Protocols
 
 */
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
