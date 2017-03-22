/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Generics
 * callout(Session Overview): In the real world we can externalized patterns into a construct that resembles something generically. Applying this type of thinking in everyday objects produces templates that we can use immediately and fill in the placeholders the pieces that are specific. Swift uses *generics* as a way to create types that are not specific and can be applied to other types but leverage the implementation in the generic.
 - - -
 */
import Foundation
/*:
 ## Our Types
 Consider the following types that we will be using in our program for building a Kennel tracking system that tracks all types of animals, not just dogs and cats.
 */
protocol SoundMaker {
    
    func makeSound() -> String
}

class Animal: SoundMaker {
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func makeSound() -> String {
        return ""
    }
}

class Dog: Animal {
    
    override func makeSound() -> String {
        return "bark"
    }
}

class Cat: Animal {
    
    override func makeSound() -> String {
        return "meow"
    }
}

let dogs: [Dog] = [Dog(name: "Fido"), Dog(name: "Spot")]

let cats: [Cat] = [Cat(name: "Snowy"), Cat(name: "Snuffles")]
/*:
 ## Why use Generics
 One of our requirement is to iterate over each animal in the kennel and supply what action should be taken for each animal. Currently we need to create 2 iterator functions, one for dogs and one for cats.
 - example: Implementation of the iterator functions for dogs and cats.
 */
func iteratorDogs(dogs: [Dog], closure: (_ dog: Dog) -> Void) {
    
    for index in 0..<dogs.count {
        
        closure(dogs[index])
    }
}

func iteratorCats(cats: [Cat], closure: (_ cat: Cat) -> Void) {
    
    for index in 0..<cats.count {
        
        closure(cats[index])
    }
}
/*:
 - example: Calling the interator functions for dog and cat.
 */
iteratorDogs(dogs: dogs) { (dog) in
    
    print("\(dog.name) makes a \(dog.makeSound()) sound.")
}

iteratorCats(cats: cats) { (cat) in
    
    print("\(cat.name) makes a \(cat.makeSound()) sound.")
}
/*:
 Notice that the implementation of both iterators is the same and the only difference is the type each iterator is using. We should be thinking of a generic way to iterate over any type of animal.
 */
/*:
 ## Using Generics with Functions
 Generic functions are not defined and implemented with specific types. They use placeholder type names that are used in the parameter list or return type which get *replaced* with the correct type. The placeholder type names are placed after the function name between two angle brackets `<...> `
 - example: Implementation of a generic iterator function that can be used with any type, not just dogs, cats, or even animals.
 */
func iterator<T>(items: [T], closure: (_ item: T) -> Void) {
    
    for index in 0..<items.count {
        
        closure(items[index])
    }
}
/*:
 - example: Calling the interator functions but passing in dogs and cats and other types.
 */
iterator(items: dogs) { (pet) in
    
    print("\(pet.name) makes a \(pet.makeSound()) sound.")
}

iterator(items: cats) { (pet) in
    
    print("\(pet.name) makes a \(pet.makeSound()) sound.")
}

iterator(items: [1, 2, 3]) { (number) in
    
    print("I'm on \(number)")
}

iterator(items: ["one", "two", "three"]) { (string) in
    
    print("I'm on \(string)")
}
/*:
 ### Multiple Type Parameters and Naming
 When creating generic functions, you can use multiple parameter type names in the generic parameter type names section, the code between the `<...>`. The parameter type names are typically `T` for type, or `Key` or `Value`. You can use one letter names or use upper camel case names for the type name.
 - example: A generic function that contains two different types that need to be used in the function signature.\
 Below the `chooseThatOverThis` generic function defines generic types `This` and `That` and will return `That`.
 */
func chooseThatOverThis<This, That>(this: This, that: That) -> That {
    
    return that
}

let thatString = chooseThatOverThis(this: "This", that: "That")
print(thatString)

let thatInt = chooseThatOverThis(this: 1, that: 10)
print(thatInt)

let thisSomething = chooseThatOverThis(this: "This", that: 10)
print(thisSomething)
/*:
 ## Generic Types
 Swift provides a way for you to create generic types, special types that can work with any type.
 - example: Below is the `Owner` generic class. You can tell it's generic because of the angle brackets.\
 `matt` is an instance of the generic `Owner` type that can only be used with the `Animal` type. There is also `sam` who is an owner of `Int`s. We can use the same `iterator` to iterate over what `matt` and `sam` own.
 */
class Owner<Something> {
    
    var items = [Something]()
    
    func addItem(item: Something) {
        
        items.append(item)
    }
}

// matt, the owner of animals

let matt = Owner<Animal>()

let fido = Dog(name: "Fido")
let spot = Dog(name: "Spot")
let snowy = Cat(name: "Snowy")
let snuffles = Cat(name: "Snuffles")

matt.addItem(item: fido)
matt.addItem(item: spot)
matt.addItem(item: snowy)
matt.addItem(item: snuffles)

iterator(items: matt.items) { (item) in
    
    print("Matt's has a pet named \(item.name)")
}

// sam, the owner of Ints

let sam = Owner<Int>()

sam.addItem(item: 1)
sam.addItem(item: 2)
sam.addItem(item: 3)

iterator(items: sam.items) { (item) in
    
    print("Sam owns \(item)")
}
/*:
 - experiment: Create another instance of the `Owner` generic type but use the `String` type as the parameter type name.
 */

/*:
 ## Extending Generic Types
 Generic types can be extended just like you extend a concrete type, by using the `extension` keyword then the name of the generic.
 - example: Below we have extended the `Owner` generic type by adding a `typealias` `Pet` to refer to parameter type name `Something`. `Pet` is a more descriptive thing for the instances of the `Owner` type. With extension, we can add computed properties, function and subscripts.
 */
extension Owner {
    
    typealias Pet = Something
    
    var firstPet: Pet? {
        
        return items.isEmpty ? nil : items.first
    }
    
    var lastPet: Pet? {
        
        return items.isEmpty ? nil : items.last
    }
    
    func addPet(item: Pet) {
        
        items.append(item)
    }
    
    var dogs: [Dog] {
        var dogs = [Dog]()
        handle { (pet) in
            if pet is Dog {
                dogs.append(pet as! Dog)
            }
        }
        return dogs
    }
    
    var cats: [Cat] {
        var cats = [Cat]()
        handle { (pet) in
            if pet is Cat {
                cats.append(pet as! Cat)
            }
        }
        return cats
    }
    
    func handle(closure: (_ pet: Pet) -> Void) {
        
        for index in 0..<items.count {
            
            closure(items[index])
        }
    }
}

let annie = Owner<Animal>()

annie.addPet(item: fido)
annie.addPet(item: spot)
annie.addPet(item: snowy)
annie.addPet(item: snuffles)

let anniesDogs = annie.dogs
iterator(items: anniesDogs) { (dog) in
    print("Annie has a dog named \(dog.name)")
}
let anniesCats = annie.cats
iterator(items: anniesCats) { (cat) in
    print("Annie has a cat named \(cat.name)")
}

if let firstPet = annie.firstPet {
    print("Annie's first pet is \(firstPet.name)")
}
if let lastPet = annie.lastPet {
    print("Annie's last pet is \(lastPet.name)")
}

annie.handle { (pet) in
    
    print("Putting \(pet.name) in the kennel.")
}
/*:
 ## Using Type Constraints
 When creating generic functions or types, you may want to further constrain what types the caller is allowed to call the function with or create an instance of the generic type.
 - example: Below we extended the `Owner` generic type by creating a function `isYappy` that can only be called with instances of a type that conforms to the `SoundMaker` protocol.
 */
extension Owner {
    
    func isYappy<T: SoundMaker>(pet: T) -> Bool {
        
        if pet is Dog {
            return true
        }
        return false
    }
}

let dogIsYappy = matt.isYappy(pet: fido)
let catIsNotYappy = matt.isYappy(pet: snowy)
/*:
 - experiment: See if you can pass an `Int` type into `isYappy`
 */

/*:
 ## Associated Types
 When creating a protocol, you can use placeholders, which are just like the parameter type names for generic functions and types, to be used within your protocol. These placeholders are called *associated type* and created with the `associatedtype` keyword. Associated types would be used when you don’t want to be specific about the type that is used in the protocol.
 - example: Below we have a `Kennel` protocol that defines the associated type `Pet`. `Pet` can be anything that makes sense to be a pet, such as an animal, dog or cat. The `BackYardKennel` type conforms to `Kennel` and in do so, uses a `typealias` to alias `Pet` for `Animal` which allows us to implement the rest of the methods in the `Kennel` protocol.
 */
protocol Kennel {
    
    associatedtype Pet
    
    func add(pet: Pet)
    
    func remove(pet: Pet) -> Pet?
    
    var count: Int { get }
    
    subscript(i: Int) -> Pet { get }
}

// to make Animal conform to Equatable

func ==(lhs: Animal, rhs: Animal) -> Bool {
    
    return lhs.name == rhs.name
}

// Animal is already conforming to Equatable, make it explicit in the extension

extension Animal: Equatable {}

class BackYardKennel: Kennel {
    
    var animals = [Animal]()
    
    // conformance to the Container protocol
    
    typealias Pet = Animal
    
    func add(pet: Pet) {
        animals.append(pet)
    }
    
    func remove(pet: Pet) -> Pet? {
        let index = animals.index { $0 == pet }
        if index != nil {
            return animals.remove(at: index!)
        }
        return nil
    }
    
    var count: Int {
        return animals.count
    }
    
    subscript(i: Int) -> Pet {
        return animals[i]
    }
}

let backYardKennel = BackYardKennel()
backYardKennel.add(pet: fido)
backYardKennel.add(pet: snowy)
backYardKennel.add(pet: spot)
backYardKennel.add(pet: snuffles)

print("I have \(backYardKennel.count) in my kennel.")

if let deadDog = backYardKennel.remove(pet: spot) {
    
    print("\(deadDog.name) died.")
}

print("I have \(backYardKennel.count) in my kennel.")
/*:
 ## The `where` clause
 For associated types, you can constrain what the caller can pass to the function or method by using a *where* clause. The *where* clause specifies what the associated type must conform to. You place the *where* clause directly after the list of type parameters.
 - example: Below we extend the `Owner` generic type by creating a method `sameKennels` that compares two kennels and returns if they are the same kennel. The method uses the `where` clause to further constrain that both kennels assiciated type `Pet` need to be of the same type and conform to the `Equatable` protocol.
 */
extension Owner {
    
    func sameKennels<K1: Kennel, K2: Kennel>(kennel1: K1, kennel2: K2) -> Bool where K1.Pet == K2.Pet, K1.Pet: Equatable {
        
        if kennel1.count != kennel2.count {
            return false
        }
        
        for i in 0..<kennel1.count {
            if kennel1[i] != kennel2[i] {
                return false
            }
        }
        
        // all items match, so return true
        return true
    }
}

// A kennel...
class BuildingKennel: Kennel {
    
    // ...that boards animals
    var animals = [Animal]()
    
    // conformance to the Kennel protocol
    
    typealias Pet = Animal
    
    func add(pet: Pet) {
        animals.append(pet)
    }
    
    func remove(pet: Pet) -> Pet? {
        let index = cats.index { $0.name == pet.name }
        if index != nil {
            return animals.remove(at: index!)
        }
        return nil
    }
    
    var count: Int {
        return animals.count
    }
    
    subscript(i: Int) -> Pet {
        return animals[i]
    }
}

// A kennel...
class BuildingCatKennel: Kennel {
    
    // ...that boards cats
    var cats = [Cat]()
    
    // conformance to the Kennel protocol
    
    typealias Pet = Cat
    
    func add(pet: Pet) {
        cats.append(pet)
    }
    
    func remove(pet: Pet) -> Pet? {
        let index = cats.index { $0.name == pet.name }
        if index != nil {
            return cats.remove(at: index!)
        }
        return nil
    }
    
    var count: Int {
        return cats.count
    }
    
    subscript(i: Int) -> Pet {
        return cats[i]
    }
}

let buildingKennel = BuildingKennel()
buildingKennel.add(pet: fido)    // a dog
buildingKennel.add(pet: snowy)   // a cat
buildingKennel.add(pet: snuffles)// a cat

print("Building kennel has \(buildingKennel.count) animals.")

let catKennel = BuildingCatKennel()
catKennel.add(pet: snowy)    // a cat
catKennel.add(pet: snuffles) // a cat
// catKennel.add(fido)  // dogs not allowed

print("Cat kennel has \(catKennel.count) cats.")

let same = matt.sameKennels(kennel1: backYardKennel, kennel2: buildingKennel)
/*:
 The following will not comple because `buildingKennel` and `catKennel` do not pass the constrains in the where clause.
 
 `let same2 = matt.sameKennels(kennel1: buildingKennel, kennel2: catKennel)`
 
 */
/*:
 - - -
 * callout(Checkpoint): At this point, you have seen how you can create generic functions, methods and types that are more flexible and reusable that can work with any type. Generics use parameter type names to specify what is required in the function or method signature as well as used in types to specify what is allowed to be used in the type. Associated types allow you to create a protocol that are not tied to a specific type and use the where clause to further constrain what types are permitted  to be passed as arguments to a method.
 
 **Keywords to remember:**
 - `associatedtype` = The creation of an associated type to be used in a protocol
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Generics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)
 - [Video: Advanced Swift](https://developer.apple.com/videos/play/wwdc2014-404/)
 - [Video: Building Better Apps with Value Types in Swift](https://developer.apple.com/videos/play/wwdc2015-414/)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
