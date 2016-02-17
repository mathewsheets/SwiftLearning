/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Functions
*/
/*:
> **Session Overview:**
> Functions are statements of code grouped together to provide readability, reusability, and modularity within your program. The Swift Standard Library provides functions that we have already used within previous Playgrounds. Please visit The Swift Standard Library [Functions](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/doc/uid/TP40016052) online resource to see the full list of global functions available to your programs.
*/
import Foundation
/*:
## Calling Functions
All functions have a name, that describes what the function will do when you *call* the function. The `print` function has a name *print* that informs the caller the function will print the parameters *passed* to the function. Functions are constructed using the following parts:
- Name of the function
- Parameters data type(s) that will be passed as arguments
- Return type of the output
*/
let i = 4
let j = 5

let biggest = max(i, j)
//: The above statements creates 2 Int constants, *calls* the function `max`, *passing* parameters i and j and *returns* an Int of which parameter is larger.
//: > **Experiment**: Call the `min` function to determine which value is smaller.

/*:
## Creating your own functions
Calling functions created outside of your program is a very common task. There will be many instances that you will have to create your own function to accomplish a specific task. The process of creating a function is also known as defining a function. You start defining a function with the `func` keyword.
*/
func sayHiTeacher() {
    
    print("Hi Teach!");
}
//: The above statement creates a function using the `func` keyword, with a name of *sayHiTeacher*, that doesn't accept parameters and doesn't return a value.
//: > **Experiment**: Call the `sayHiTeacher` function.

/*:
## Passing parameters
Functions can be defined with no parameters or with many parameters. The above function `max` is defined with 2 parameters and the `print` function is defined without parameters. Parameters are data types such as `Int`s, `Bool`eans, `String`s and complex types such as [Enumerations](Enumerations), [Classes & Structures](Classes%20and%20Structures) explained in future sessions.
*/
/*:
### Functions Without Parameters
The above function `sayHiTeacher` is and example of a function defined without parameters.
*/
//: > **Experiment**: Create and call a function to print your name. Define the function with a name of your choice, without parameters and no return value.

/*:
### Functions With Multiple Parameters
The above function `max` is and example of a function defined with multiple parameters. The `min` function is also a function defined with multiple parameters.
*/
func sayHiTeacher2(name: String, className: String) {
    
    print("Hi \(name), from my \(className) class");
}
sayHiTeacher2("Mr. Sheets", className: "Swift")
//: The above statement creates a function `sayHiTeacher2` defined with accepting 1 parameter of type String.
//: > **Experiment**: Create and call a function to print your name and age. Define the function with a name of your choice, with a parameter of a `String` and `Int` data types and no return value.

/*:
### Function Parameter Names
There are two possible names you can give parameters when defining a function. The *local* parameter name is only available for use within the function body. The *external* parameter name is used by the caller to label arguments passed with calling a function. All functions have *local* parameter names name must be unique when defining the function.
*/
/*:
### Specifying External Parameter Names
*External* parameter names are exposed to the caller of the function. *External* and *local* parameter names don't have to be the same and by default the first parameter doesn't have an external name and all subsequent *local* names are also the *external* names. The `sayHiTeacher2` function is an example of a function omitting the *external* name for the first parameter and using the default external name for the second parameter.
*/
func sayHiTeacher3(teacherName name: String, className: String) {
    
    print("Hi \(name), from my \(className) class");
}
sayHiTeacher3(teacherName: "Mr. Sheets", className: "Swift")
/*:
### Omitting External Parameter Names
You can omit *external* names by using the underscore `_` in front of second or subsequent parameters.
*/
func sayHiTeacher4(name: String, _ className: String) {
    
    print("Hi \(name), from my \(className) class");
}
sayHiTeacher4("Mr. Sheets", "Swift")
/*:
### Default Parameter Values
Function parameters can be set to a default value and omitted from a function call. It's recommended that you place all defaulted parameters at the end of the parameter list.
*/
func sayHiTeacher5(name: String = "Mr. Sheets", _ className: String = "Swift") {
    
    print("Hi \(name), from my \(className) class");
}
sayHiTeacher5()
/*:
### Variadic Parameters
Functions can be defined with accepting a varying number of arguments (zero or more) when called. You used the three dot notation `...` after the parameter type name. A function can only have at most 1 variadic parameter.
*/
func sayHiTeacher6(name: String, classNames: String ...) {
    
    var classes = ""
    for className in classNames {
        classes += className + " "
    }
    
    print("Hi \(name), from my \(classes)classes");
}
sayHiTeacher6("Mr. Sheets", classNames: "Swift 1", "Swift 2", "Swift 3")
/*:
### Constant and Variable Parameters
By default function parameters are defined as constants, meaning that you are not allowed to change the value. You can also define parameters as variable, providing you the ability to change the value and not define another variable with in your function.
*/
func sayHiTeacher7(var teacherName name: String, className: String) {
    
    if !name.hasPrefix("Mr.") {
        name = "Mr. " + name;
    }
    
    print("Hi \(name), from my \(className) class");
}
sayHiTeacher7(teacherName: "Sheets", className: "Swift 1")
//: The above variable parameter `name`'s value was changed within the function body but changing the value of variable parameters has no impact outside of the function.
/*:
### In-Out Parameters
As mentioned above, changing the value of a variable parameter doesn't change the value of the argument variable. If you want the changes to a variable parameter to be reflected outside of your function body, you can define the variable parameter with the `inout` keyword. You place an `&` in front of the varable argument to indicate that the function can modify the value.
*/
func sayHiTeacher8(inout name: String, _ className: String) {
    
    if !name.hasPrefix("Mr.") {
        name = "Mr. " + name;
    }
    
    print("Hi \(name), from my \(className) class");
}

var teacherName = "Sheets";

sayHiTeacher8(&teacherName, "Swift 1")

print(teacherName)
//: The above variable `teacherName`'s value was changed within the function body and now has a new value.
/*:
## Return values
When defining a function, the part that describes the output of calling the function is called the `return` value. You indicate what you are *returning* from a function using the right arrow `->`. The return value from a function can be ignored when it is called.
*/
func getHello() -> String {
    return "Hello";
}
let hello = getHello()
getHello()
/*:
### Functions Without Return Values
As we have seen above, functions don't always have to return a value. A function without a return value (or omitting the function definition return syntax) is the same as including the return syntax of ` -> Void`.
*/
func sayHi() -> Void {
    print("Hi");
}
sayHi()
/*:
### Functions with Multiple Return Values
There are instances where returning multiple values from a function is needed. Swift provides tuples as a return type enabling you to return multiple values grouped together in one return type.
*/
func ends(names: String ...) -> (first: String, last: String)? {
    
    if names.isEmpty { return nil }
    
    var first = "z"
    var last = "."
    
    for name in names[0..<names.count] {
        
        if name < first {
            first = name
        } else if name > last {
            last = name
        }
    }
    
    return (first, last)
}

let firstLastName = ends("Mathew", "Sam", "Jack", "Annie", "Oliver", "Hudson")
if firstLastName != nil {
    
    print("first = \(firstLastName!.first), last = \(firstLastName!.last)")
}

let none = ends()
if none != nil {
    
    print("first = \(none!.first), last = \(none!.last)")
}
//: The above function `ends` defines variadic parameter of `String`s and returns an optional tuple.
/*:
## Function as Types
We have already learned about data types such as `Int` and `String` in which you declare that a constant or variable stores a certain *type* of data. Functions are *types* as well. Function types are comprised of parameter types and the return type of the function.
*/
func twice(num: Int) -> Int {
    
    return 2 * num
}
//: The type of the `twice` function is `(Int) -> Int`. In the case of the `sayHiTeacher`, the function type is `() -> Void`.
/*:
Since functions are types, you can refer to the function in a constant or variable like:
*/
let doubleIt: (Int) -> Int = twice
// or simply using type inference
let doubleItAgain = twice

print(doubleItAgain(4))
/*:
### Function Types as parameter types
Function types can also be used as parameters, meaning that you can pass functions as arguments to another function.
*/
func printTwice(twiceFunction: (Int) -> Int, _ num: Int) {
    
    print(twiceFunction(num))
}
printTwice(doubleItAgain, 8)
/*:
The `printTwice` function has two parameters. The first parameter `twiceFunction` is of type `(Int) -> Int` and the second parameter is an `Int`. You can pass any function type that conforms to `(Int) -> Int` to the `printTwice` function. The second parameter is used as an argument for the first parameter function type.
*/
/*:
### Function Types as a return type
Function types can also be used as return types, meaning that you can return a functions within a function. Defining a function that returns a function is done by placing the function type after the defined function's return arrow `-> `.
*/
func sayHello(name: String) -> String {
    
    return "Hello " + name + "!"
}
func sayGoodBye(name: String) -> String {
    
    return "GoodBye " + name + "!"
}

func saySomething(justMet: Bool) -> (String) -> String {
    
    return justMet ? sayHello : sayGoodBye;
}

print(saySomething(true)("Chris"))

print(saySomething(false)("Jason"))
/*:
Here we have defined two functions, one that returns a `String` saying 'hello' to someone and another function that returns a `String` saying 'good bye' to someone. The third function defined `saySomething` accepts as an argument a `Boolean` if whether you just met someone and returns the appropriate function type to be called at a later time. The `firstTime` and `longTimeFriends` constants refer to different function on which you can call passing a `String` of a persons name as an argument.
*/
/*:
## Nesting Functions
The function examples above are called *global functions*. A *global* function means that the function is visible from anywhere and anytime. Nested functions, functions within functions, are visible only to the function containing the nested function.
*/
func saySomethingNesting(justMet: Bool) -> (String) -> String {
    
    func hello(name: String) -> String {
        
        return "Hello " + name + "!"
    }
    func goodBye(name: String) -> String {
        
        return "GoodBye " + name + "!"
    }
    
    return justMet ? hello : goodBye;
}

print(saySomethingNesting(true)("Chris"))

print(saySomethingNesting(false)("Jason"))
/*:
Above we rewrote the `saySomething` *global* function as `saySomethingNesting`, *nesting* functions `hello` and `goodBye` and return the correct nested function.
*/
/*:
## Guarding
A good practice when creating functions is to test that the inputs are valid. The `guard` statement is like an `if` statement except that a `guard` requires that you have an `else` for the false condition. If the `guard` statement evaluates to `false` the statements in the `else` are executed and *must* exit the function.
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

*/
/*:
### Code with Errors in mind.

*/
enum GradeError: ErrorType {
    case MissingLetter
    case BadLetter(youPassed: String, shouldBe: String)
    case BadNumber
}
/*:
### Throw it here

*/
func createGrade(number: Int, letter: String) throws -> (Int, String)? {
    
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
    case (80..<89, let letter) where letter != "B":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "B")
    case (70..<79, let letter) where letter != "C":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "C")
    case (60..<69, let letter) where letter != "D":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "D")
    case (0..<59, let letter) where letter != "F":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "F")
    default:
        break;
    }
    
    return gradeTuple;
}
/*:
Above ...
*/
/*:
### Catch it there

*/
do {
    let myGrade = try createGrade(101, letter: "A")
    
    print("my grade is \(myGrade!.0) or a \(myGrade!.1)")
    
} catch GradeError.BadLetter(let passed, let shouldBe) {
    print("You passed a letter of \(passed), but it should be \(shouldBe)")
} catch GradeError.MissingLetter {
    print("You didn't passed in a letter")
} catch GradeError.BadNumber {
    print("You passed in a bad number")
}
/*:
Above ...
*/
/*:
## Clean up after yourself

*/
func createMyGrade(number: Int, letter: String) throws -> (Int, String)? {
    
    do {
        defer {
            print("2: order")
        }
        defer {
            print("3: in reverse")
        }
        defer {
            print("4: defer statements are executed")
        }
        
        let myGrade = try createGrade(number, letter: letter)
        
        guard (myGrade != nil) else {
            
            return nil
        }
        
        print("1: my grade is \(myGrade!.0) or a \(myGrade!.1)")
        
        return myGrade
        
    } catch GradeError.BadLetter(let passed, let shouldBe) {
        
        print("You passed a letter of \(passed), but it should be \(shouldBe)")
        
        throw GradeError.BadLetter(youPassed: passed, shouldBe: shouldBe)
    }
}

let myGrade = try createMyGrade(93, letter: "A")
/*:
Above ...
*/
/*:
**Exercise:** Create a playground with pages with each playground page consisting of the previous four exercises. Refactor each exercise leveraging collection types and functions.
*/
/*:
**Checkpoint:**
At this point, you should have a good understanding of calling and creating functions. Functions can be declared with or without parameters and with or without return values. Functions can also indicate that an exception could occur as well as exit early if certain conditions are met.
*/
/*:
**Keywords to remember:**
- `func` = to declare a function
- `inout` = changing a value of a parameter will change the value of the argument
- `return` = exiting a function passing to the caller a potential value
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
- [Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html)
- [Control Flow](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)
- [Error Handling](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
