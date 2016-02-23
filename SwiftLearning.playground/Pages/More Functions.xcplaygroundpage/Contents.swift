/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# More Functions
*/
/*:
> **Session Overview:**
> ADD CONTENT
*/
import Foundation
/*:
## Guarding
A good practice when creating functions is to test that the parameter values are valid. The `guard` statement is like an `if` statement except that a `guard` requires that you have an `else` for the false condition. If the `guard` statement evaluates to `false` the statements in the `else` are executed and *must* exit the function.
*/
func printGrade(grade: (Int, String)) {
    
    guard grade.0 >= 0 && grade.0 <= 100 else {
        print("Wrong Grade Number!")
        return
    }
    
    guard ["A", "B", "C", "D", "F"].contains(grade.1) else {
        print("Wrong Grade Letter!")
        return
    }
    
    print("Your grade is \(grade.0) or a \(grade.1)")
}

printGrade((101, "A"))
printGrade((55, "E"))
printGrade((94, "A"))
/*:
Above we validate the grade number and grade letter using a `guard` statement and only executing the correct print statement if the grade number and grade letter are in the correct range.
*/
/*:
## Error Handling
Something can always go wrong when making programs. These wrong things are called exceptions, like *exception to the rule*. Swift provides a way to handle exceptions when they occur and also cause exceptions to occur to indicate to the caller that an error condition was met.
*/
/*:
### Code with Errors in mind.
When throwing exceptions, the value that is thrown is an `ErrorType`. The most common way to create an `ErrorType` is by creating an *enumeration* conforming to a *protocol* of `ErrorType` ([Enumerations](Enumerations) and [Protocols](Protocols) will be explained in more detail in later sessions).
*/
enum GradeError: ErrorType {
    case MissingLetter
    case BadLetter(youPassed: String, shouldBe: String)
    case BadNumber
}
/*:
Above we create `GradeError`, conforming to the *protocol* `ErrorType` with cases of `MissingLetter`, `BadLetter`, `BadNumber`
*/
/*:
### Throw it here
To indicate to the caller that an exception condition could be met is by using the `throws` keyword. Then within the function, when the exception condition is met you cause the exception to execute by using the `throw` keyword.
*/
func createGrade(number: Int, letter: String) throws -> (Int, String) {
    
    guard number >= 0 && number <= 100 else {
        throw GradeError.BadNumber
    }
    guard !letter.isEmpty else {
        throw GradeError.MissingLetter
    }
    
    let gradeTuple = (number, letter);
    
    switch gradeTuple {
    case (90...100, let letter) where letter != "A":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "A")
    case (80...89, let letter) where letter != "B":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "B")
    case (70...79, let letter) where letter != "C":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "C")
    case (60...69, let letter) where letter != "D":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "D")
    case (0...59, let letter) where letter != "F":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "F")
    default:
        break;
    }
    
    return gradeTuple;
}
/*:
Above we test the valid values of the parameters, throwing exceptions if the values are not in the correct range.
*/
/*:
### Catch it there
When you are calling a function that `throws` exceptions you can `catch` the possible exceptions by wrapping the function call in `do{...} catch{...}` statement, with each catch representing each possible exception. Then use the keyword `try` before the call to the function.
*/
do {
    let myGrade = try createGrade(93, letter: "B")
//    let myGrade = try createGrade(100, letter: "")
//    let myGrade = try createGrade(101, letter: "A")

    print("my grade is \(myGrade.0) or a \(myGrade.1)")

} catch GradeError.BadLetter(let passed, let shouldBe) {
    print("You passed a letter of \(passed), but it should be \(shouldBe)")
} catch GradeError.MissingLetter {
    print("You didn't passed in a letter")
} catch GradeError.BadNumber {
    print("You passed in a bad number")
}
/*:
Above we call `createGrade` inside a do/catch statement executing the function call with a try.
*/
/*:
## Clean up after yourself
There are occations that you want to force the execution of code to always happen when exiting a function. This can be accomplished by using the keyword `defer`. You can have as many `defer` statments with varying kinds of scope. `defer` statements are executed in reverse order.
*/
func createMyGrade(number: Int, letter: String) throws -> (Int, String)? {
    
    defer {
        print("4: order")
    }
    defer {
        print("3: in reverse")
    }
    
    do {
        defer {
            print("2: defer statements are executed")
        }

        let myGrade = try createGrade(number, letter: letter)

        print("1: my grade is \(myGrade.0) or a \(myGrade.1)")

        return myGrade

    } catch GradeError.BadLetter(let passed, let shouldBe) {

        print("You passed a letter of \(passed), but it should be \(shouldBe)")

        return nil
    }
}

let myGrade = try createMyGrade(93, letter: "A")
/*:
Above we use the `defer` statement to force the execution of statements when the function exits.
*/
/*:
## Closures
Closures are self contained functions that are able to reference other constants or variables that are defined in that same context. Global and nested functions are actually closures, but have different rules for what constants and variables they can reference. Unnamed closures have a terse syntax that can reference values from their surrounding context.
*/
/*:
## Passing Closures
Just like normal functions, closures are data types themselves, allowing you to assign them to constants or variables as well as arguments to other functions.
*/
let family = [(name: "Oliver",  role: "child",  age: 1),
            (name: "Matt",      role: "father", age: 39),
            (name: "Sam",       role: "child",  age: 10),
            (name: "Jack",      role: "child",  age: 7),
            (name: "Hudson",    role: "child",  age: 5),
            (name: "Annie",     role: "mother", age: 37)]

func sortFamily(element1: (String, String, Int), element2: (String, String, Int)) -> Bool {

    return element1.2 < element2.2
}

let orderedByAge = family.sort(sortFamily)

print(orderedByAge)
//: Above we are calling the sort method of an Array passing in a closure. The Closure is defined with two parameters, both being of the same type, in this case a tuple of `(String, String, Int)`.
/*:
### The Syntax
Notice above that the syntax for a closure is just like the functon syntax. There are parameters, a return type and a group of statements, the function body. We could have also used the closure expression syntax described below.
*/
/*:
`{ (parameters) -> return type} in ... }`
*/
/*:
Using the closure expression syntax allows us to be more expressive when dealing with closures.
*/
/*:
### Inferring Types
Above constant `sortFamily` stores a reference to a closure that is later passed in as an argument to the sort method of an array. But leveraging the closure expression syntax our code is more consise.
*/
let inferring = family.sort({ element1, element2 in return element1.name < element2.name })

print(inferring)
//: Above we don't need to include the definition of `element1` and `element2` because they are inferred from of the context, `family` consisting of data types of `(String, String, Int)`
/*:
### Returning without writing it
When a closure body is a single expression, the `return` keyword can be omitted, inferring that the return is satisfied from `element1.name < element2.name`
*/
let noreturn = family.sort({ element1, element2 in element1.name < element2.name })

print(noreturn)
//: Above we omit the `return` keyword, continuing to reduce the code to satisfied the closure definition.
/*:
### Shorthand
For inline closures using the closure expression syntax, Swift automatically provides access to the arguments using the index of the argument prefixed with `$`
*/
let shorthand = family.sort({ $0.name < $1.name })

print(shorthand)
//: Above we use the shorthand argument names, such as `$0` and `$1` to access the argument values, and are allowed to omit the argument list from the definition.
/*:
### Even more terse... Operator Functions
One last way to write a closure for the sort method is to leverage the data types implementation of the greater-than operator. `Int` overloads the greater-than operator for the purpose of only having to deal with the `Int` data type.
*/
var ages: [Int] = []
for member in family {
    ages.append(member.age)
}

let terse = ages.sort(<)

print(terse)
//: Above we collect all the ages into the `ages` variable and sort only using the greater-than operator. We could have also used the less-then operator, since the `Int` data type provides it's own implementation.
/*:
### Trailing Closures

*/
func printSpecifics(member: (name: String, role: String, age: Int), closure: ((name: String, role: String, age: Int) -> String)) {
    
    print(closure(member))
}

for member in family.sort({ $0.age > $1.age }) {
    
    // closure expression within parentheses
    
    printSpecifics(member, closure: { (name, role, age) -> String in
        
        return name
    })
    
    // trailing closure outside and after parentheses
    
    printSpecifics(member){ (name, role, age) -> String in
        
        return role
    }
}
/*:
## Referring to Closures

*/
var names: [String] = []
for member in family {
    names.append(member.name)
}

let sortedName = names.sort(<)

print(sortedName)

let sortTheNames = names.sort

print(sortTheNames())
/*:
## Access to outer variables

*/
func counter(closure: (counter: Int) -> Void) -> () -> Void {
    
    var counter = 0;
    
    func call() {
        
        ++counter
        closure(counter: counter);
    }
    
    return call
}

let call = counter { (counter) -> Void in print("called \(counter) times") }

for times in 0..<5 { call() }
/*:
## Creating Closures

*/
func each(items: [String], closure: (item: String, index: Int) -> Void) {
    
    func iterator(items: [String], closure: (item: String) -> Void) {
        
        for var index = 0; index < items.count; ++index {
            
            closure(item: items[index])
        }
    }
    
    var index = 0;
    
    iterator(items) { (item) -> Void in
        
        closure(item: item, index: index++)
    }
}

each(["Mathew", "Annie", "Sam", "Jack", "Hudson", "Oliver"]) { (item, index) in
    
    print("item \(index) is \(item)")
}
/*:
### Autoclosures

*/
func sayHello(talk: () -> Void) {
    
    talk()
}

sayHello({ print("Hello!") })

func sayGoodbye(@autoclosure talk: () -> Void) {
    
    talk()
}

sayGoodbye(print("Goodbye!"))

var talking: [() -> Void] = []

func chatter(@autoclosure(escaping) talk: () -> Void) {
    
    talking.append(talk)
}

chatter(print("Hello!"))
chatter(print("Goodbye!"))
chatter(print("Hello!"))
chatter(print("Goodbye!"))
chatter(print("Hello!"))

for talk in talking {
    
    talk()
}
/*:
**Exercise:**
*/
/*:
**Checkpoint:**
At this point, ...
*/
/*:
**Keywords to remember:**
- `guard` = used to test conditions and if false, short circuit the function
- `do` = indicate a block of code that handles exceptions
- `try` = execute a statement that could throw an exception
- `throw` = to make an exception happen
- `throws` = used on a function declarations to tell the caller that an exception could happen
- `catch` = block of code to execute for a specific exception
- `defer` = block of code to execute after the function exits either by completing, returning or catching
*/
/*:
**Supporting Chapters:**
- [Control Flow](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)
- [Error Handling](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html)
- [Closures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
