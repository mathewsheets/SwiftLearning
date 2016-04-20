/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Generics
 * callout(Session Overview): ADD
 */
import Foundation
/*:
 ## Why use Generics
 
 */
protocol SoundMaker {
    
    func makeSound() -> String
}
class Animal {
    
    var name: String
    init(name: String) {
        self.name = name
    }
    
    func makeSound() -> String {
        return ""
    }
}
class Dog: Animal, SoundMaker {

    override func makeSound() -> String {
        return "bark"
    }
}

class Cat: Animal, SoundMaker {

    override func makeSound() -> String {
        return "meow"
    }
}

let dogs = [Dog(name: "Fido"), Dog(name: "Spot")]

let cats = [Cat(name: "Snowy"), Cat(name: "Snuffles")]

func iteratorDogs(dogs: [Dog], closure: (dog: Dog) -> Void) {
    
    for index in 0..<dogs.count {
        
        closure(dog: dogs[index])
    }
}

func iteratorCats(cats: [Cat], closure: (cat: Cat) -> Void) {
    
    for index in 0..<cats.count {
        
        closure(cat: cats[index])
    }
}

iteratorDogs(dogs) { (dog) in
    
    print("\(dog.name) makes a \(dog.makeSound()) sound.")
}

iteratorCats(cats) { (cat) in

    print("\(cat.name) makes a \(cat.makeSound()) sound.")
}
/*:
 ## Using Generics with Functions
 
 */
func iterator<T>(items: [T], closure: (item: T) -> Void) {

    for index in 0..<items.count {

        closure(item: items[index])
    }
}

iterator(dogs) { (pet) in

    print("\(pet.name) makes a \(pet.makeSound()) sound.")
}

iterator(cats) { (pet) in

    print("\(pet.name) makes a \(pet.makeSound()) sound.")
}
/*:
 ### Multiple Type Parameters and Naming
 
 */
func chooseThatOverThis<This, That>(this: This, that: That) -> That {

    return that
}

let that = chooseThatOverThis("This", that: "That")

print(that)
/*:
 ## Generic Types
 
 */
class Owner<Pet> {

    var pets = [Pet]()

    func addPet(pet: Pet) {

        pets.append(pet)
    }
}

let matt = Owner<Animal>()

let fido = Dog(name: "Fido")
let spot = Dog(name: "Spot")
let snowy = Cat(name: "Snowy")
let snuffles = Cat(name: "Snuffles")

matt.addPet(fido)
matt.addPet(spot)
matt.addPet(snowy)
matt.addPet(snuffles)

iterator(matt.pets) { (item) in
    
    print("Matt's has a pet named \(item.name)")
}
/*:
 ## Extending Generic Types
 
 */
extension Owner {
    
    var firstPet: Pet? {
        
        return pets.isEmpty ? nil : pets.first
    }
    
    var lastPet: Pet? {
        
        return pets.isEmpty ? nil : pets.last
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
    
    func handle(closure: (pet: Pet) -> Void) {
        
        for index in 0..<pets.count {

            closure(pet: pets[index])
        }
    }
}

let annie = Owner<Animal>()

annie.addPet(fido)
annie.addPet(spot)
annie.addPet(snowy)
annie.addPet(snuffles)

let anniesDogs = annie.dogs
iterator(anniesDogs) { (dog) in
    print("Annie has a dog named \(dog.name)")
}
let anniesCats = annie.cats
iterator(anniesCats) { (cat) in
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
 
 */
extension Owner {

    func isYappy<T: SoundMaker>(pet: T) -> Bool {

        if pet is Dog {
            return true
        }
        return false
    }
}

let dogIsYappy = matt.isYappy(fido)
let catIsNotYappy = matt.isYappy(snowy)
/*:
 ## Associated Types
 
 */
func ==(lhs: Animal, rhs: Animal) -> Bool {
    
    return lhs.name == rhs.name
}

protocol Kennel {

    associatedtype Pet

    func add(pet: Pet)
    
    func remove(pet: Pet) -> Pet?
    
    var count: Int { get }

    subscript(i: Int) -> Pet { get }
}

class BackYard: Kennel {

    var animals = [Animal]()

    // conformance to the Container protocol
    
    typealias Pet = Animal

    func add(pet: Pet) {
        animals.append(pet)
    }

    func remove(pet: Pet) -> Pet? {
        let index = animals.indexOf { $0.name == pet.name }
        if index != nil {
            return animals.removeAtIndex(index!)
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

/*:
 ## The `where` clause

 */

/*:
 - - -
 * callout(Exercise): ADD
 
 **Constraints:**
 - ADD
 
 * callout(Checkpoint): ADD
 
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Generics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)
 - [Video: Advanced Swift](https://developer.apple.com/videos/play/wwdc2014-404/)
 - [Video: Building Better Apps with Value Types in Swift](https://developer.apple.com/videos/play/wwdc2015-414/)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
