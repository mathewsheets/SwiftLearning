/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Collection Types
 * callout(Session Overview): Often times in programs you need to group data into a single container where the number of items is unknown. Swift provides 3 main containers known as *collection types* for storing collections of values. *Arrays* are ordered collections of values, *Sets* are unordered collections of unique values, and *Dictionaries* are unordered collections of key-value associations. Please visit the Swift Programming Language Guide section on [Collection Types](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105) for more detail on collection types.
  - - -
 */
import Foundation
/*:
 ## When you're allowed to change or *mutate* collections
 Before we dive into detail on collection types, there's a suttle but easy way to indicate if you can mutate your collection type. We have already seen this with simple data types such as `Int` and `String`, you use `let` and `var`.
 */
let unmutableArray: [String] = ["One", "Two"]
//unmutableArray.append("Three")

var mutableArray: [Int] = [1, 2]
mutableArray.append(3)


//: > **Experiment**: Uncomment the unmutableArray.append statement.
/*:
 ## Arrays
 An *Array* stores values of the same type, `Int`s, `String`s, ect. in ordered manner. The same value of the type can appear multiple times at different positions of the array.
 */
/*:
 ### Creating Arrays
 Swift's *arrays* need to know what type of elements it will contain. You can create an empty array, create an array with a default size and values for each element, create an array by adding multiple arrays together and create arrays using literals.
 */
/*:
 **A new empty Array**
 > You can create an array explicitly with the type or when appropriate use type inference.
 */
var array: [Int] = [Int]()
array = []
print("array has \(array.count) items.")
//: The above statements show two ways to create a new array, allowing only to store `Int`s and print the number of elements.
/*:
 **A new Array with default values**
 >You can create an array with default values by using the *initializer* that accepts a default value and a repeat count of how many elements the array should contain
 */
let nineNines = [Int](repeating: 9, count: 9)
print("nineNines has \(nineNines.count) items.")
//: The above statements creates an array nine `Int`s all with a value of 9 and print the number of elements nineNines contains.
/*:
 **A new Array by adding Arrays together**
 >You can create an array by taking two *arrays* of the same type and adding them together usng the addition operator `+`. The new array's type is inferred from the type of the two arrays added together.
 */
let twoTwos = [Int](repeating: 2, count: 2)
let threeThrees = [Int](repeating: 3, count: 3)
let twosAndThrees = twoTwos + threeThrees
print("twosAndThrees has \(twosAndThrees.count) items.")
let threesAndTwos = threeThrees + twoTwos
print("threesAndTwos has \(threesAndTwos.count) items.")
//: The above statements creates two arrays by adding two other arrays together.
/*:
 **A new Array using Array literal**
 >You can create an array by using the literal syntax such as creating an array of `Ints` like `[1, 2, 3, 4, 5]`.
 */
let numbers = [1, 2, 3, 4, 5]
//: The above statement creates an array of numbers containing `Int` data types.
/*:
 ### Accessing data in an `Array`
 You can access information and elements in an array by using the methods and properties provided by the `Array` collection type.
 */
print("numbers has \(numbers.count) elements")

if numbers.isEmpty {
    print("numbers is empty")
} else {
    print("numbers is not empty")
}

var firstNumber = numbers.first
var lastNumber = numbers.last
//: The above statements use properties of the `Array` collection type for count, empty, first element, and last element.
var secondNumber = numbers[1]
var thirdNumber = numbers[2]
//: The above statements use *subscript syntax* by passing the index of the value you want in square brackets after the name of the array.
var oneTo4 = numbers[0...3]
//: You can also get a subset of elements using ranges.
let startIndex = numbers.startIndex
let endIndex = numbers.endIndex
numbers[numbers.index(after: startIndex)]         // Get the element after the startIndex
numbers[numbers.index(before: endIndex)]          // Get the element before the endIndex
numbers[numbers.index(startIndex, offsetBy: 1)]   // Get the element using the startIndex as a starting point with an offset of 1
numbers[numbers.index(endIndex, offsetBy: -4)]    // Get the element using the endIndex as a starting point with an offset of -4
//: And much like a String, you can use the various index methods to get elements.
/*:
 ### Modifying `Array`s
 Using methods such as `append` and `remove` let you mutate an array.
 */
var mutableNumbers = numbers

mutableNumbers.append(6)
mutableNumbers.append(7)
mutableNumbers.append(8)

mutableNumbers.removeFirst()
mutableNumbers.removeLast()
mutableNumbers.remove(at: 0)

mutableNumbers.removeSubrange(mutableNumbers.index(mutableNumbers.startIndex, offsetBy: 2)..<mutableNumbers.endIndex)

mutableNumbers[0] = 1
mutableNumbers[1] = 2

mutableNumbers.append(3)
mutableNumbers.append(4)
mutableNumbers.append(5)

mutableNumbers[0...4] = [5, 6, 7, 8, 9]

mutableNumbers.insert(10, at: mutableNumbers.endIndex)

print(mutableNumbers)
//: The above statements using the `append`, `insert`, `remove` methods, *subscript syntax* as well as using a range to replace values of indexes.
/*:
 ### Iterating over elements in an `Array`
 You use the `for-in` loop to iterate over elements in an `Array`
 */
for number in numbers {
    print(number)
}

for (index, number) in numbers.enumerated() {
    print("Item \(index + 1): \(number)")
}
//: The first `for-in` loop just pulls out the value for each element in the array, but the second `for-in` loops pulls out the index and value.
//: > **Experiment**: Use an `_` underscore instead of `name` in the above for loop. What happens?

/*:
 ## Sets
 The `Set` collection type stores unique value of the same data type with no defined ordering. You use a `Set` instead of an `Array` when you need to ensure that an element only appears once.
 */
/*:
 ### Hash Values for Set Types
 For a `Set` to ensure that it contains only unique values, each element must provide a value called the *hash value*. A *hash value* is an `Int` that is calulated and is the same for all objects that compare equally. Simple types such as `Int`s, `Double`s, `String`s, and `Bool`s all provide a *hash value* by default.
 */
let one = 1
let two = "two"
let three = Double.pi
let four = false
one.hashValue
two.hashValue
three.hashValue
four.hashValue
/*:
 ### Creating Sets
 You create a new set collection type by specifing the data type for the element as in `Set<Element>` where `Element` is the data type the set is allowed to store.
 */
var alphabet = Set<Character>()
alphabet = []
/*:
 The above statements create an empty set that is only allowed to store the Character data type. The second statment assigns *alphabet* to an empty array using the array literal and type inference.
 */
//: **A new Set using Array literal**
var alphabet1: Set<Character> = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
var alphabet2: Set = ["j", "k", "l", "m", "n", "o", "p", "q", "r"]
//: You can create a new `Set` using the array literal, but you need to type the variable or constant. `alphabet2` is a shorter way to create a `Set` because it can be inferred that all the values are of the same type, in this case `String`s. Notice that `alphabet1` and `alphabet2` are not of the same type.
/*:
 ### Accessing data in a `Set`
 Similar to the `Array` collection type, you access information and elements in an `Set` using properties and methods of the `Set` collection type.
 */
alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m"]

print("alphabet has \(alphabet.count) elements")

if alphabet.isEmpty {
    print("alphabet is empty")
} else {
    print("alphabet is not empty")
}

var firstLetter = alphabet.first
//: The above statements use properties of the `Set` collection type for count, empty, and first element.
var secondLetter = alphabet[alphabet.index(alphabet.startIndex, offsetBy: 1)]
var thirdLetter = alphabet[alphabet.index(alphabet.startIndex, offsetBy: 2)]
//: The above statements use *subscript syntax* by passing the index of the value you want in square brackets after the name of the set.
/*:
 ### Modifying elements in a Set
 Using methods such as `insert` and `remove` let you mutate a set.
 */
alphabet.insert("n")
alphabet.insert("o")
alphabet.insert("p")

alphabet.removeFirst()
alphabet.remove(at: alphabet.startIndex)

alphabet.remove("o")

print(alphabet)
//: The above statements using the `insert` and `remove` methods to mutate the `Set`.
/*:
 ### Iterating over elements in a Set
 You use the `for-in` loop to iterate over elements in an `Set`
 */
for letter in alphabet {
    print(letter)
}

for (index, value) in alphabet.enumerated() {
    
    print("index: \(index) - value: \(value)")
}
//: The first `for-in` loop just pulls out the value for each element in the set, but the second `for-in` first sorts the set before the looping starts.
/*:
 ### Set Operations
 With the `Set` collection type, you can perform set operations in the mathematical sense.
 */
alphabet = ["a", "b", "c", "d", "e", "v", "w", "x", "y", "z"]
var vowels : Set<Character> = ["a", "e", "i", "o", "u"]
//: **intersection(_:)** creates a new `Set` of only those values both sets have in common.
let intersection = vowels.intersection(alphabet)
//: **symmetricDifference(_:)** creates a new `Set` of values from either set, but not from both.
let symmetricDifference = vowels.symmetricDifference(alphabet)
//: **union(_:)** creates a new `Set` with all values from both sets.
let union = vowels.union(alphabet)
//: **subtracting(_:)** creates a new `Set` with values not in the specified set.
let subtracting = vowels.subtracting(alphabet)
/*:
 ### Set Membership and Equality
 With the `Set` collection type, you can determine the membership of a set and if one set is equal to another.
 */
let family : Set = ["Matt", "Annie", "Samuel", "Jack", "Hudson", "Oliver"]
let parents : Set = ["Matt", "Annie"]
let children : Set = ["Samuel", "Jack", "Hudson", "Oliver"]
//: **“is equal” operator (==)** tests if one set is equal to another set.
family == parents.union(children)
parents == children
//: **isSubset(of:)** tests if all of the values of a set are contained in another set.
children.isSubset(of: family)
family.isSubset(of: children)
//: **isSuperset(of:)** test if a set contains all of the values in another set.
family.isSuperset(of: parents)
family.isSuperset(of: children)
children.isSuperset(of: family)
//: **isStrictSubset(of:) or isStrictSuperset(of:)** test if a set is a subset or superset, but not equal to, another set.
let old = parents
old.isStrictSubset(of: parents)
let boys: Set = ["Matt", "Samuel", "Jack", "Hudson", "Oliver"]
boys.isStrictSubset(of: family)
//: **isDisjoint(with:)** test if two sets have any values in common.
parents.isDisjoint(with: children)
family.isDisjoint(with: children)
/*:
 ## Dictionaries
 A `Dictionary` stores associations or mappings between keys of the same data type and values of the same data type in a container with no defined ordering. The value of each element is tied to a unique *key*. It's this unique *key* that enables you to lookup values based on an identifer, just like a real dictionary having the word be the key and the definition the value.
 */
/*:
 ### Creating Dictionaries
 Much like the `Array` and `Set` collection types, you need to specify the data type that the `Dictionary` is allowed to store. Unlike `Array`s and `Set`s, you need to specify the data type for the *Key* and the *Value*.
 */
var longhand: Dictionary<String, String>? = nil
var shorthand: [String: String]? = nil
/*:
 Above shows a long and short way to create a dictionary.
 */
//: **A new empty Dictionary**
var titles = [String: String]()
titles["dad"] = "Matt"
titles = [:]
/*:
 Above creates an empty `Dictionary`, adds an entry into `titles` and then assigns `titles` to an empty dictionary using the shorthand form and type inference.
 */
//: **A new Dictionary using Dictionary literal**
titles = ["dad": "Matt", "mom": "Annie", "child_1": "Sam", "child_2": "Jack", "child_3": "Hudson", "child_4": "Oliver"]
/*:
 Above creates a `Dictionary` using the literal syntax. Notice the *key: value* mapping separated by a comma, all surrounded by square brackets.
 */
/*:
 ### Accessing data in a Dictionary
 Like the `Array` and `Set` collection types, the `Dictionary` also has the `count` and `isEmpty` properties, but unlike arrays and sets, you access elements using a *key*.
 */
print("titles has \(titles.count) elements")

if titles.isEmpty {
    print("titles is empty")
} else {
    print("titles is not empty")
}

var dad = titles["dad"]
if dad != nil {
    print(dad!)
}
/*:
 Above statements use the `count` and `isEmpty` properties, as well as use the *key* to retrive a value. It's possible that you use a *key* that does not exist in the dictionary. The `Dictionary` collection type will always return the value as an *Optional*. You then next would need to check for `nil` and *unwrap* the optional to obtain the real value.
 */
/*:
 ### Modifying elements in a Dictionary
 There are two techniques to add/update entries for the `Dictionary` collection type, by using the *subscript syntax* or using a method.
 */
titles["dog"] = "Carson"
titles["child_1"] = "Samuel"

var father = titles.updateValue("Mathew", forKey: "dad")
var cat = titles.updateValue("Fluffy", forKey: "cat")

titles["dog"] = nil
cat = titles.removeValue(forKey: "cat")
if cat != nil {
    print("removed \(cat!)")
}
/*:
 The above statements use both the *subscript syntax* and methods for add, updating, and removing entries of a dictionary. Notice that with the method technique, you are returned a value if if the entry exists in the dictionary.
 */
/*:
 ### Iterating over elements in a Dictionary
 Just like the `Array` and `Set` collection types, you iterate over a dictionary using a `for-in` loop.
 */
for element in titles {
    print("\(element.0): \(element.1)")
}

for (key, value) in titles {
    print("\(key): \(value)")
}

for title in titles.keys {
    print("title: \(title)")
}

for name in titles.values {
    print("name: \(name)")
}

let titleNames = [String](titles.keys)

let names = [String](titles.values)
/*:
 Above statements use the `for-in` loop to iterate over the `titles` giving you access to the *key* and *value*. You can also access only the *keys* or *values*.
 */
//: > **Experiment**: Create a array of dictionaries and iterate over the array printing the key and value of each dictionary

/*:
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Collection Types](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
