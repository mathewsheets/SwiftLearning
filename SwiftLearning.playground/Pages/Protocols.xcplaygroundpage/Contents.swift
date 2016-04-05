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

//saunya
//abby
//katie
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
