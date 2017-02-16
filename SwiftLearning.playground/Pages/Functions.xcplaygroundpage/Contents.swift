/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 # Functions
 * callout(Session Overview): Functions are statements of code grouped together to provide readability, reusability, and modularity within your program. The Swift Standard Library provides functions that we have already used within previous Playgrounds. Please visit The Swift Standard Library [Functions](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/doc/uid/TP40016052) online resource to see the full list of global functions available to your programs.

 - - -
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
    
    print("Hi Teach!")
}
//: The above statement creates a function using the `func` keyword, with a name of *sayHiTeacher*, that doesn't accept parameters and doesn't return a value.
//: > **Experiment**: Call the `sayHiTeacher` function.

/*:
 ## Passing parameters
 Functions can be defined with no parameters or with many parameters. The above function `max` is defined with 2 parameters and the `print` function is defined without parameters. Parameters are data types such as `Int`s, `Bool`eans, `String`s and complex types such as [Enumerations](Enumerations) and [Classes & Structures](Classes%20and%20Structures), explained in future sessions.
 */
/*:
 ### Functions Without Parameters
 The above function `sayHiTeacher` is an example of a function defined without parameters.
 */
//: > **Experiment**: Create and call a function to print your name. Define the function with a name of your choice, without parameters and no return value.

/*:
 ### Functions With Multiple Parameters
 The above function `max` is an example of a function defined with multiple parameters. The `min` function is also a function defined with multiple parameters.
 */
func sayHiTeacher2(name: String) {
    
    print("Hi \(name)")
}
sayHiTeacher2(name: "Mr. Sheets")
//: The above statement creates a function `sayHiTeacher2` defined with accepting 1 parameter of type String.
//: > **Experiment**: Create and call a function to print your name and age. Define the function with a name of your choice, with a parameter of a `String` and `Int` data types and no return value.

/*:
 ### Function Parameter Names
 There are two possible names you can give parameters when defining a function. The *parameter name* is only available for use within the function body. The *argument label* is used by the caller to label arguments passed when calling a function. Functions *argument label* and *parameter* names must be unique when defining the function.
 */
/*:
 ### Specifying Argument Label Names
 *Argument label* names are exposed to the caller of the function. *Argument label* and *parameter* names don't have to be the same. The `sayHiTeacher3` function is an example of a function specifying the *argument label* name for the first parameter and using the default *Argument label* name for the second parameter. *Argument labels* are not allowed to be used within the implementation of a function.
 */
func sayHiTeacher3(teacherName name: String, className: String) {
    
    print("Hi \(name), from my \(className) class")
}
sayHiTeacher3(teacherName: "Mr. Sheets", className: "Swift")
/*:
 ### Omitting Argument Label Names
 You can omit *argument label* names by placing the underscore `_` in front of the *parameter name*.
 */
func sayHiTeacher4(_ name: String, _ className: String) {
    
    print("Hi \(name), from my \(className) class")
}
sayHiTeacher4("Mr. Sheets", "Swift")
/*:
 ### Default Parameter Values
 Function parameters can be set to a default value and omitted from a function call. It's recommended that you place all defaulted parameters at the end of the parameter list.
 */
func sayHiTeacher5(name: String = "Mr. Sheets", _ className: String = "Swift") {
    
    print("Hi \(name), from my \(className) class")
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
    
    print("Hi \(name), from my \(classes)classes")
}
sayHiTeacher6(name: "Mr. Sheets", classNames: "Swift 1", "Swift 2", "Swift 3")
/*:
 ### Constant and Variable Parameters
 By default function parameters are defined as constants, meaning that you are not allowed to change the value. If you want the parameter to be a variable, you can redefine the parameter as a variable, providing you the ability to change the value and not define another variable with a different name.
 */
func sayHiTeacher7(teacherName name: String, className: String) {
    
    var name = name
    if !name.hasPrefix("Mr.") {
        name = "Mr. " + name
    }
    
    print("Hi \(name), from my \(className) class")
}
sayHiTeacher7(teacherName: "Sheets", className: "Swift 1")
//: The above parameter `name`'s value was changed within the function body but changing the value of variable parameters has no impact outside of the function.
/*:
 ### In-Out Parameters
 As mentioned above, changing the value of a parameter doesn't change the value of the argument variable for value types. If you want the changes to a parameter to be reflected outside of your function body, you can define the parameter with the `inout` keyword. You place an `&` in front of the varable argument to indicate that the function can modify the value.
 */
func sayHiTeacher8(name: inout String, _ className: String) {
    
    if !name.hasPrefix("Mr.") {
        
        name = "Mr. " + name
    }
    
    print("Hi \(name), from my \(className) class")
}

var teacherName = "Sheets"

sayHiTeacher8(name: &teacherName, "Swift 1")
//: The above variable `teacherName`'s value was changed within the function body and now has a new value.
/*:
 ## Return values
 When defining a function, the part that describes the output of calling the function is called the `return` value. You indicate what you are *returning* from a function using the right arrow `->`. The return value from a function can be ignored when it is called.
 */
func getHello() -> String {
    
    return "Hello"
}
let hello = getHello()
getHello()
/*:
 ### Functions Without Return Values
 As we have seen above, functions don't always have to return a value. A function without a return value (or omitting the function definition return syntax) is the same as including the return syntax of ` -> Void`.
 */
func sayHi() -> Void {
    
    print("Hi")
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
        }
        if name > last {
            last = name
        }
    }
    
    return (first, last)
}

if let (first, last) = ends(names: "Mathew", "Sam", "Jack", "Annie", "Oliver", "Hudson") {
    
    print("first = \(first), last = \(last)")
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
printTwice(twiceFunction: doubleItAgain, 8)
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
    
    return justMet ? sayHello : sayGoodBye
}

print(saySomething(justMet: true)("Chris"))

print(saySomething(justMet: false)("Jason"))
/*:
 Here we have defined two functions, one that returns a `String` saying 'hello' to someone and another function that returns a `String` saying 'good bye' to someone. The third function defined `saySomething` accepts as an argument a `Boolean` if whether you just met someone and returns the appropriate function type to be called at a later time. The `firstTime` and `longTimeFriends` constants refer to different function on which you can call passing a `String` of a persons name as an argument.
 */
/*:
 ## Nesting Functions
 The function examples above are called *global functions*. A *global* function means that the function is visible from anywhere and anytime. Nested functions, functions within functions, are visible only to the function containing the nested function.
 */
func saySomethingNested(justMet: Bool) -> (String) -> String {
    
    func hello(name: String) -> String {
        
        return "Hello " + name + "!"
    }
    func goodBye(name: String) -> String {
        
        return "GoodBye " + name + "!"
    }
    
    return justMet ? hello : goodBye
}

print(saySomethingNested(justMet: true)("Chris"))

print(saySomethingNested(justMet: false)("Jason"))
/*:
 Above we rewrote the `saySomething` *global* function as `saySomethingNested`, *nesting* functions `hello` and `goodBye` and return the correct nested function.
 */
/*:
 - - -
 **Keywords to remember:**
 - `func` = to create a function
 - `inout` = changing a value of a parameter will change the value of the argument
 - `return` = exiting a function passing to the caller a potential value
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Functions](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
