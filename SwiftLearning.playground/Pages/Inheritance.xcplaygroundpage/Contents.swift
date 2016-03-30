/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Inheritance
*/
/*:
 > **Session Overview:** Code reuse is paramount in all programming languages. For languages that support object orientated programming or *OOP*, such as Swift, code inheritance is a technique in sharing and extending code within your programs.
 */
import Foundation
/*:
 ## What Is It?
 When you think of inheritance, you probably think of material wealth that your parents or grandparents pass along to you when they die. Or possibly the genes you inherited from your parents and grandparents. Those aspects also ring true in object oriented programming. In the context of OOP, inheritance means that a class can inherit properties and methods from a superclass. The class that inherited the properties and methods is called the subclass. Swift only has the capability of single inheritance, meaning that a Swift class can only inherit from one superclass. Also, inheritance only applies to reference types, a.k.a classes.
 */
/*:
 ## The Base Class
 Classes that don’t inherit from any other class is called the base class. Unlike most OOP languages, Swift classes don’t inherit from a universal base class like *Object*. Classes you define without specifying a superclass automatically become base classes for you do subclass.
 */
class Father {

    var name: String
    var height: Float
    var hairColor: String
    var eyeColor: String

    init(name: String, height: Float, hairColor: String, eyeColor: String) {

        self.name = name
        self.height = height
        self.hairColor = hairColor
        self.eyeColor = eyeColor
    }

    func sayHello() -> String {
        
        return "Hello! My name is \(name)."
    }

    var description: String {

        return "I'm \(height) inches, with \(hairColor) hair and \(eyeColor) eyes"
    }
}

let steve = Father(name: "Steve", height: 76, hairColor: "Blond", eyeColor: "Blue")

print(steve.sayHello())
print(steve.description)
/*:
 
 */
/*:
 ## The Subclass
 Having a class inherit from another class, or subclassing and superclass is done with the colon `:` directly after the class name and then the class you want to inherit after the colon. Once a class is defined as having subclassing another class, the subclass can immediately access the visible properties and methods (type and instance). The subclass can also have new properties and methods.
 */
class Son: Father {

    var age: Int?
}

let joe = Son(name: "Joe", height: 67, hairColor: "Blond", eyeColor: "Green")

joe.age = 18

print(joe.sayHello())
print(joe.description)
/*:
 
 */
/*:
 ## Accessing superclass initializers, properties, methods and subscripts
 The subclass can access the properties and methods from the superclass by using the keyword `super` in front of the property or method you want to access. The `super` keyword can also be used with initializers to delegate initialization to the superclass to initialize stored properties of the superclass.
 */
class Mother {
    
    var name: String
    var height: Float
    var hairColor: String
    var eyeColor: String
    
    init(name: String, height: Float, hairColor: String, eyeColor: String) {
        
        self.name = name
        self.height = height
        self.hairColor = hairColor
        self.eyeColor = eyeColor
    }
    
    func sayHello() -> String {
        
        return "Hello! My name is \(name)."
    }
    
    var description: String {
        
        return "I'm \(height) inches, with \(hairColor) hair and \(eyeColor) eyes"
    }
}

class Daughter: Mother {

    var age: Int
    
    init(age: Int, name: String, height: Float, hairColor: String, eyeColor: String) {

        self.age = age

        super.init(name: name, height: height, hairColor: hairColor, eyeColor: eyeColor)
    }

    func sayHi() -> String {

        let hello = sayHello()
        let description = super.description

        return "\(hello) I'm the daughter. \(description)"
    }
}

let amelia = Daughter(age: 18, name: "Amelia", height: 61, hairColor: "Brown", eyeColor: "Brown")

print(amelia.sayHi())
/*:
 
 */
/*:
 ## Overriding
 A subclass can change the implementation of a property and method (both type and instance) or a subscript that is inherited from a superclass by *overriding* the implementation inherited. This is done with the `override` keyword in front of the property, method or subscript you want to override.
 */
/*:
 ## Overriding Methods
 Overriding a method (either instance or type) is done by placing the `override` keyword before the function definition. If you override a method that is not defined in the superclass, you will receive a compiler error. When you override a method, it’s the implementation of the subclass that gets executed.
 */
class Grandson: Son {

    override func sayHello() -> String {

        return "\(super.sayHello()) I'm the grandson."
    }
}

let grandson = Grandson(name: "Sam", height: 48, hairColor: "Blond", eyeColor: "Green")

print(grandson.sayHello())
/*:
 
 */
/*:
 ## Overriding Properties
 Overriding a property (either instance or type) is similar to overriding a function; you also place the override keyword before the property definition. It doesn’t matter if the superclass’s property is a stored property or computed property. You can override a property in a subclass as long as the name and type are the same as the superclass. You can override a property’s get and set methods as well as the property observers.
 */
class Granddaughter: Daughter {
    
    // Overriding Property Getters and Setters
    
    override var height: Float {
        get {
            
            return super.height / 12
        }
        set {
            
            super.height = newValue * 12
        }
    }
    
    // Overriding Property Observers

    override var age: Int {
        willSet {

            print("age will be \(newValue)")
        }
        didSet {

            print("age was \(oldValue) and is now \(age)")
        }
    }

    override var description: String {

        return "I'm \(self.height) feet, with \(hairColor) hair and \(eyeColor) eyes"
    }
}

let granddaughter = Granddaughter(age: 5, name: "Olivia", height: 44, hairColor: "Brown", eyeColor: "Blue")

granddaughter.height = 5
granddaughter.age = 6

print(granddaughter.description)
/*:
 
 */
/*:
 ## Inheritance and Initialization
 When inheriting properties, especially stored properties, from a superclass, you not only need to initialize store properties within your subclass, you also need to initialize properties in the superclass. You can require an initializer to be present in a subclass with the require keyword preceding the custom initializer. The required custom initializer forces all subclasses to implement the superclass’s required custom initializer.
 */
class Lightsaber {
    
    var color: String
    var length: Int?
    
    required init(color: String) {
        
        self.color = color
    }

    convenience init(color: String, length: Int) {

        self.init(color: color)

        self.length = length
    }
    
    func hitType() -> String {
        
        return "Hit"
    }

    var description: String {

        return "Lightsaber"
    }
}

class JediLightsaber: Lightsaber {

    required init(color: String) {

        super.init(color: color) // delegating to the superclass
    }

    override func hitType() -> String {

        return "Smack"
    }
}
/*:
 
 */
/*:
 ## Preventing Overrides
 
 */
class SithLightsaber: Lightsaber {
    
    required init(color: String) {
        
        super.init(color: color)
    }
    
    final override func hitType() -> String {

        return "Slam"
    }
}

final class DoubleEdged: SithLightsaber {

//    override func hitType() -> String {
//
//        return "Bang"
//    }
}
/*:
 
 */
/*:
 ## Type Casting

 */
class JediTrainerLightsaber: JediLightsaber {
    
    override var description: String {
        
        return "\(color) Trainer \(super.description)"
    }
}

class SithTrainerLightsaber: SithLightsaber {
    
    override var description: String {
        
        return "\(color) Trainer \(super.description)"
    }
}

let jediTrainer = JediTrainerLightsaber(color: "Blue")
let sithTrainer = SithTrainerLightsaber(color: "Red")

var trainers = [Lightsaber]()
trainers.append(jediTrainer)
trainers.append(sithTrainer)
/*:
 
 */
/*:
 ### Checking the type

 */
for trainer in trainers {
    
    if trainer is JediTrainerLightsaber {

        print("Jedi \(trainer.color) Trainer Lightsaber")
        
    } else if trainer is SithTrainerLightsaber {
        
        print("Sith \(trainer.color) Trainer Lightsaber")
    }
}
/*:
 
 */
/*:
 ### Downcasting to get the type
 
 */
for trainer in trainers {
    
    if let jediTrainer = trainer as? JediTrainerLightsaber {
        
        print("\(jediTrainer.hitType()) \(jediTrainer.description)")
    }
    
    if trainer is SithTrainerLightsaber {
        
        let sithTrainer = trainer as! SithTrainerLightsaber
        
        print("\(sithTrainer.hitType()) \(sithTrainer.description)")
    }
}
/*:
 
 */
/*:
 ### Type Casting for Any and AnyObject

 // is and as
 
 */
var anyObjects = [AnyObject]()

anyObjects.append(steve)            // instance of Father
anyObjects.append(joe)              // instance of Son, subclass of Father
anyObjects.append(amelia)           // instance of Daughter, subclass of Mother
anyObjects.append(jediTrainer)      // instance of JediTrainerLightsaber
anyObjects.append(sithTrainer)      // instance of SithTrainerLightsaber
anyObjects.append("A random String")// instance of String
anyObjects.append(100)              // instance of Int

for anyObject in anyObjects {
    switch anyObject {
    case let son as Son:
        print("I'm \(son.name), an instance of Son")
    case let father as Father:
        print("I'm \(father.name), an instance of Father")
    case is Daughter:
        print("I'm an instance of Daughter")
    case let jediLightsaber as JediTrainerLightsaber:
        print("I'm \(jediLightsaber.color), an instance of JediTrainerLightsaber")
    case let sithLightsaber as SithTrainerLightsaber:
        print("I'm \(sithLightsaber.color), an instance of SithTrainerLightsaber")
    case let someString as String:
        print("I'm a String with a value of \(someString)")
    case let someInt as Int:
        print("I'm an Int with a value of \(someInt)")
    default:
        print("I'm something strange")
    }
}

var anyThings = [Any]()

for anyObject in anyObjects {
    anyThings.append(anyObject)
}

anyThings.append((name: "Matt", age: 33))

func twice(num: Int) -> Int {
    return num * 2
}

anyThings.append(twice)

for anyThing in anyThings {
    switch anyThing {
    case let child as Father:
        print("I'm an instance of Father")
    case let child as Mother:
        print("I'm an instance of Mother")
    case let lightsaber as Lightsaber:
        print("I'm an instance of Lightsaber")
    case is String:
        print("I'm a String")
    case is Int:
        print("I'm a Int")
    case let (name, age) as (String, Int):
        print("I'm a tuple with name: \(name), age: \(age)")
    case let twice as (num: Int) -> Int:
        let amount = 4
        print("I'm a closure that can twice something like \(amount) * 2 = \(twice(num: amount))")
    default:
        print("I'm something strange")
    }
}
/*:
 
 */
/*:
 **Exercise:**
 */
/*:
 **Constraints:**

 */
/*:
 **Checkpoint:**
 At this point,
 */
/*:
 **Keywords to remember:**
 - `super` = To access a superclass's properties, methods or subscripts
 - `override` = Overriding a property or method of a base class
 - `required` = All subclasses must implement an initializer that is `required`
 - `final` = A class, property or method that cannot be overridden
 - `is` = Type check operator to check if an instance is of a specific type
 - `as` = Type cast operator that will downcast to the subclass type. Use `as?` of casting can fail, use `as!` if downcast will always succeed
 - `AnyObject` = Represents an instance of any class type
 - `Any` = Represents an instance of any type, including function types and tuples
 */
/*:
**Supporting Chapters:**
- [Inheritance](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Inheritance.html)
- [Type Casting](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TypeCasting.html)
- [Video: Intermediate Swift](https://developer.apple.com/videos/play/wwdc2014-403/)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
