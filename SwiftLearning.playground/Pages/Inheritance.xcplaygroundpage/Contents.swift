/*:
[Table of Contents](@first) | [Previous](@previous) | [Next](@next)
*/
/*:
# Inheritance
*/
/*:
 > **Session Overview:** Code reuse is paramount in all programming languages. For languages that support object oriented programming or *OOP*, such as Swift, code inheritance is a technique in sharing and extending code within your programs.
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
 Above we created a `Father` class. This is the base class for all subclasses of a `Father` class. We have also created an instance of the `Father` class providing the necessary arguments to initialize the `Father` class correctly.
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
 Above we have created the subclass `Son`. The `Son` class inherited all the properties and methods from the `Father` class. `Son` also defined a new property `age`. Notice when we created an instance of `Son` we are able to call the method `sayHello()` and access the computed property`description`.
 */
/*:
 ## Accessing superclass initializers, properties, methods and subscripts
 The subclass can access properties and methods from the superclass by using the keyword `super` in front of the property or method you want to access. The `super` keyword can also be used with initializers to delegate initialization to the superclass to initialize stored properties of the superclass.
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

print(amelia.sayHello())
print(amelia.sayHi())
/*:
 Above we create a base class `Mother` and a subclass `Daughter`. The `Daughter` class inherits all the properties and methods from `Mother` and can call methods and access properties by using the `super` keyword. The `Daughter` class leverages the superclass’s initializer and the property `description` within the initializer and `sayHi()` method.
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
 Above we have created a new class `Grandson` inheriting from the `Son` class. We want the `sayHello` method of the `Grandson` class to provide a different implementation. We do this by overriding the `sayHello` method defined in the base class `Father`.
 */
/*:
 ## Overriding Properties
 Overriding a property (either instance or type) is similar to overriding a function; you also place the override keyword before the property definition. It doesn’t matter if the superclass’s property is a stored property or computed property. You can override a property in a subclass as long as the name and type are the same as in the superclass. You can override a property’s get and set methods as well as the property observers.
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
 Above we have created a new class `Granddaughter` inheriting from the `Daughter` class. We override the `height` property by providing custom implementations of the `get` and `set` property methods. We also override the `age` property and provide property observers. Finally we override the `description` computed property printing out a different string than what is implemented in the `Mother` class.
 */
/*:
 ## Inheritance and Initialization
 When inheriting properties, especially stored properties, from a superclass, you not only need to initialize store properties within your subclass, you also need to initialize properties in the superclass. You can require an initializer to be present in a subclass with the `require` keyword preceding the custom initializer. The required custom initializer forces all subclasses to implement the superclass’s required custom initializer.
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
 Above we have created a `Lightsaber` class and have made the `init(color: String)` initializer required for all subclasses. We have also created a convenience initializer that also accepts length. The subclass `JediLightsaber` must also implement the `init(color: String)`. The `JediLightsaber` also overrides the method `hitType() -> String`
 */
/*:
 ## Preventing Overrides
 To prevent a class from being overridden, use the final keyword preceding the class keyword in the class definition. You can also prevent a specific property, method, or subscript from being overridden with the `final` keyword.
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

    // this will cause a compiler error
    
//    override func hitType() -> String {
//
//        return "Bang"
//    }
}
/*:
 Above have create two new classes. `SithLightsaber`, inherits from `Lightsaber`, and `DoubleEdged` inherits from `SithLightsaber`. The `hitType() -> String` method is overridden in but `SithLightsaber` prevents all subclass of `SithLightsaber` to override `hitType() -> String`. `DoubleEdged` will never be a superclass because of the `final` keyword in the the class definition.
 */
/*:
 ## Type Casting
 When working with class hierarchies that you have created in your program or provided to you from a framework, it’s often necessary to check if a class can become a specific type and perform type casting to make the object that your are working with become a valid type in the hierarchy.
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
 Above we have created two new classes `JediTrainerLightsaber` and `SithTrainerLightsaber`. We store instances of these two classes in an array storing instances of `Lightsaber`. This is allowable because our instances of `JediTrainerLightsaber` and `SithTrainerLightsaber` have the same base class `Lightsaber`.
 */
/*:
 ### Checking the type
 You can check the type of an instance of a class by using the type check operator `is`. The `is` keyword checks if a class is of a certain subclass. The type check operator will return `true` if the class can be casted as the subclass and `false` if the class is not in the class hierarchy.
 */
for trainer in trainers {
    
    if trainer is JediTrainerLightsaber {

        print("Jedi \(trainer.color) Trainer Lightsaber")
        
    } else if trainer is SithTrainerLightsaber {
        
        print("Sith \(trainer.color) Trainer Lightsaber")
    }
}
/*:
 Above we iterate over the `trainers` array and use the type check operator `is` to print the correct string for each `trainer`.
 */
/*:
 ### Downcasting to get the type
 To actually cast a class as a subclass, downcasting, use the type cast operator `as` with either a question mark `?` or exclamation point `!`. Use `as?` if you are unsure if the class belongs in the class hierarchy, resulting in a `nil` if the class is not in the hierarchy. Conversely, use `as!` to force the type casting. If the class is not in the hierarchy, you will receive a runtime error.
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
 Above we iterate over the `trainers` array and use the type cast operator to print the correct string for each `trainer`. The first `if` uses optional binding with the type cast operator `as?` for optional downcasting. The second `if` uses the type check operator and then the `as!` type cast operator to force the downcasting.
 */
/*:
 ### Type Casting for Any and AnyObject
 Some frameworks that you will leverage within your program store an array of non specified types and indicate so with either using `typealias` of `AnyObject` or `Any`. `AnyObject` marks the type or collection of types as instances of classes. `Any` marks the type of collection of any thing, including tuples and function type. You can use the `is`, type check operator or `as`, type cast operator to determine what it is you are actually working with.
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
/*:
 Above we create an array that can store any instance of a class by using the typealias `AnyObject`. We add instances of `Father`, `Son`, `Daughter`, `JediTrainerLightsaber`, `SithTrainerLightsaber` and instances of a `String` and `Int`. We then iterate over the array and by leveraging the `switch-case` statement match on the correct type using `is` and `as` and print the correct string.
 */
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
 Above we do something similar to storing instances of `AnyObject`, here we store an array of `Any`, representing any type, such as tuples of function types. Again we iterate and use the `switch-case` statement to match on a type and print the correct string.
 */
/*:
 **Exercise:**
 Build upon your `Dog` and `Cat` classes in the previous exercise by applying inheritance. Create a superclass that both `Dog` and `Cat` can inherit from. Modify your `Owner` class to hold a collection of pets. Iterate over your pets and print what sound the pet makes.
 */
/*:
 **Constraints:**
 - Create a new class as the superclass to `Dog` and `Cat`
 - The superclass needs to have a method of `makeSound()`
 - The subclasses need to override the `makeSound()` method and print the appropriate sound
 - The `pets` property needs to store both `Dog` and `Cat` instances
 */
/*:
 **Checkpoint:**
 At this point, you have learned how to leverage inheritance to share and reuse code and how to access the properties, methods and subscripts of a superclass. Overriding a superclass provide a subclass with having it’s custom implementation of a property, method or subscript. You can prevent a class, property, method or subscript from being overridden with he `final` keyword. `AnyObject` and `Any` are used to mark a type or collection of types as unspecified types while using the type check operator and type cast operator to convert the type type into a type you are interested in.
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
[Table of Contents](@first) | [Previous](@previous) | [Next](@next)
*/
