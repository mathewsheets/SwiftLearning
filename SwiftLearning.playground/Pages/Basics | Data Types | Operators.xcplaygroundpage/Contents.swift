/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Basics | Data Types | Operators
*/
/*:
**Session Overview:**
All software languages have building blocks or foundational concepts upon which large programs are implemented. These building blocks first need to be understood in order to move to more functional aspects of the language. This session focuses on the basics of the Swift language, simple data types that are used extensively throughout your programs, and the most common operators such as assignment, adding and equals operators.
*/
/*:
## The Important `import` statement
The first line of text you will see within a file of a program is a statement that tells the compiler what external libraries or frameworks your program will use. The following statement `import Foundation` is telling the compiler to make available to my program all the Classes, Protocols, Functions, Constants, Data Types defined within the `Foundation` framework (a.k.a library). Please visit the Foundation Framework [Reference](https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/ObjC_classic/index.html) to see what is available to your program. The `Foundation` framework is provided to us by Apple. Custom frameworks can also be used and/or created for your program.
*/
import Foundation
//: > **Experiment**: Put an `s` at the end of `Foundation`. Is there an indication that something is wrong?

/*:
## Storing values
Storing information within your program is a basic necessity. Swift provides two ways to store values. The first way is to store a value that you know will never change. This is referred to as a constant. The second way is to store value that will vary over time. This is referred to as a variable. The process of storing values, either constants or variables is referred to as assignment. When creating a constant or variable, you can use almost any characters or Unicode characters, but your constant or variable cannot begin with a number or contain whitespace, mathematical symbols or arrows.
*/
/*:
The **`let`** keyword stores constants
*/
let π = 3.14159265358979

let school = "Columbus State"
let teacher = "Mathew Sheets"
//: > **Experiment**: Assign `teacher` another value.

/*:
The **`var`** keyword stores variables
*/
var student = "John Doe"
var studentGrade = "A"
var numberOfCredits = 14
//: > **Experiment**: Assign `studentGrade` another value.

/*:
## Printing values
Being able to print values of constants and variables is an easy way to see the true value of what's stored. Provided to your program is the `print` function. A more detail explanation of functions is covered in a later session.
*/
print(school)
print(teacher, terminator: "")
//: The `terminator` in the statement `print(teacher, terminator: "")` tells the `print` function to not append the new line character `\n`.
//: You can also combine other text and your constant or variable to be passed to the `print` function. This is called *string interpolation*.
print("\(school) is a great place to learn mobile development!")
print("\(teacher) is an adjunct professor at \(school).")
//: > **Experiment**: Assign `student` to your name and print the value of the grade you would like to get.

/*:
## Comments
You describe the intent of program statements or a set of program statements by using Comments. When creating a comment, restrain from duplicating your code. Instead describe the "What", not the how.
*/
/*
This is a comment that will wrap multiple lines of text.
This helps readability.

/*
You can also nest multiline comments.
*/

*/

// This is a comment for one line.
/*:
## Type Safety
Swift is a type safe language. This means that the compiler will ensure to some reason of accuracy the correctness of using types (Numbers, String, Boolean, custom types) within your program. Your program will not compile if you assign a String to an Int constant or variable.
*/
var anInt = 5
//anInt = "five" // -> this is a compile error. Uncomment this statement to see what the compiler tells you.
//: Within the notion of type safety, the compiler is intelligent enough to determine that `anInt` is an `Int` because of it's initial value of `5`. This is called type inference, meaning that the compiler inferred that the variable `anInt` is an `Int`. To be explicit about the type of constant or variable, you can use a type annotation by following the constant or variable with `: Int`.
var an5Int: Int = 5
/*:
## Numbers
When your programs needs to store numbers, Swift provides 3 main types, `Int`s, `Double`s, and `Float`s.
*/
//: ### `Int`
//: An integer is a whole number, or an number without decimal places that could be either negative, positive, or zero.
let aNumber = 3
var positive = 4
var negative = -4

var yourNumber: Int = 4
//: > **Experiment**: Change the assignment of `yourNumber` to 4.1.

/*:
Swift also provides more explicit storage limits for numbers.
>Int(8-64) can store either positive or negative numbers, a.k.a signed number.
*/
let int8: Int8 = -123
let int16: Int16 = 12345
let int32: Int32 = 123456789
let int64: Int64 = -1234567890123456789
//: UInt(8-64) can only store positive numbers, a.k.a unsigned number.
let uint8: UInt8 = 123
let uint16: UInt16 = 12345
let uint32: UInt32 = 123456789
let uint64: UInt64 = 1234567890123456789
//: > **Experiment**: For each of the above integers, add 1 more number.

/*:
With the `Int` type, you can access the lower bounds and upper bounds with the min and max properties.
*/
let smallestNumber = Int64.min
let largestNumber = Int64.max
/*:
### Floating point numbers
A floating point number is a number that has decimal places or the fractional part, such 3.1459. Swift provides to signed floating point numbers, `Double` and `Float`.
*/
/*:
### `Double`
A `Double` floating point number can store at least 15 decimal places.
*/
let aDouble: Double = 3.14159265358979
/*:
### `Float`
A `Float` floating point number can store at least 6 decimal places.
*/
let aFloat: Float = 3.141592
/*:
### Number Conversion
On occasion, your program will have to calculate a value using a combination of differing number types, such as adding an `Int` to a `Double`. Since Swift is a type safe language, you need to convert all types into one consistent type to compile. Number literals don't need to be converted prior because the compile will choose the correct type for each literal number.
*/
let one = 1
let pointSixOneEight = 0.618
let phi = Double(one) + pointSixOneEight
//: > **Experiment**: What happens when we convert a `Double` to an `Int`.

/*:
## Booleans
Booleans are a very simple data type that either store values for true or false. The two constants available in Swift to for storing boolean values are simply `true` and `false.` Boolean are usually used in if-else control flow statements, discussed in more detail in the [Control Flow](Control%20Flow) session.
*/
var trueValue = true
let falseValue = false

var trueValue2: Bool
trueValue2 = true

var falseValue2: Bool
falseValue2 = false
/*:
## Strings
The String data type stores text, such as "Hello Student!". There no limit to the amount of text that you can store in a String constant or variable. The only limit that could be reach is the memory your program is allowed to use. The `String` data type is a very rich data type with other properties and behaviors that will be discuss int the [Strings & Characters](Strings%20and%20Characters) session.
*/
var message = "Helo Student!"
var message2: String = "Hello again"
/*:
## Tuples
Tuples provide the means to group values into a single value. Values within a tuple can be of any data type and each value can be a different data type from the others.
*/
let course = (1000, "Swift: The Programming Language")
//: Above creates a tuple of type (`Int`, `String`).
//: You can access values within the tuple using the number index (zero based).
print(course.0)
print(course.1)
//: You can create a tuple using "named values" and gain access to the stored values using the specified names.
let course2 = (id: course.0, name: course.1)
print(course2.id)
print(course2.name)
//: You can unpack a tuple into separate elements and access each element's value.
let (courseId, courseName) = course2
print(courseId)
print(courseName)
//: You can target a particular element within a tuple and skip the unpacking of the other elements.
let (courseId2, _) = course2
print(courseId2)
//: > **Experiment**: Create a tuple with values for each data type above, Int, Double, String, Boolean. Print out each value by it's index and name and select an element within the tuple to print.

/*:
## Something to remember me by: Type Aliases
Have you ever wanted to rename something because the given name didn't seem appropriate for the context it was in. Enter `typealias`.
*/
typealias SmallestRangeNumber = Int8
typealias LargestRangeNumber = Int64

print(SmallestRangeNumber.min)
print(SmallestRangeNumber.max)
print(LargestRangeNumber.min)
print(LargestRangeNumber.max)
//: Here we created two typealaises, one to represent a number with the smallest range, -128 - 127 and one to represent the largest range -9223372036854775808 - 9223372036854775807.
/*:
## Nil & Optionals
When storing values in either a constant or a variable, a statement may actually store nothing. Swift provides optionals to indicate within the program that there is a value and it is *x* or there isn't a value at all. Optionals can be applied to any type when declaring a constant or variable. You indicate an optional on types with a *?* question mark, meaning that the constant or variable might contain some typed value or might contain no value at all. Most other programming languages use a sentinel value, (a value to indicate that special handling needs to occur) such as -1, NotFound, or null. Optionals provide a clear and consistent way throughout your program to indicate what will *always* have a value and what *might* have a value.
*/
/*:
### The "valueless" value
Within a program, you assign a value or no value to a constant or variable. At a minimum, after the assignment, your constant or variable either has a value, such as false, 1, 3.1459, "Hi" or it is valueless, meaning the constant or variable doesn't have a value. Swift provides the `nil` keyword to represent "no value".
*/
var valueless: Int? = nil
//: The above statement declares the variable *valueless*, forcing the allowed type to be assigned as an Int? (an optional integer number) as well as stating that there could or could not be a value assigned. In this case, we assign `nil`, meaning initially valueless.
//: > **Experiment**: print out the value of `valueless`

/*:
### Simple Optional Types
Any type can be an optional type, from simple types such as `Int` to more complex types such as instances of classes (explained in more detail in session [Classes & Structures](Classes%20and%20Structures))
*/
var valueOrValuelessBoolean: Bool?
valueOrValuelessBoolean = true
valueOrValuelessBoolean = nil

var valueOrValuelessString: String?
valueOrValuelessString = "Howdy There!"
valueOrValuelessString = nil

var valueOrValuelessInt: Int?
valueOrValuelessInt = 3
valueOrValuelessInt = nil

var valueOrValuelessDouble: Double?
valueOrValuelessDouble = 3.141592653589793238462643383279502884197169399375105820974944592307816406286208998628034
valueOrValuelessDouble = nil

var valueOrValuelessFloat: Float?
valueOrValuelessFloat = 3.1459
valueOrValuelessFloat = nil
/*:
The above statements declare variables of types Boolean, String, Int, Double, and Float, each initialized with `nil` or no value, assigned with the appropriate type and then set to `nil` again.
*/
/*:
### Unwrapping Optionals
Within your program, you will use constants and variables and return types from functions that are indicated as optionals. Now that you have access to an optional, you need to determine if you can access it's value. If you know for certain that the optional has a value, you obtain the value by using the `!` exclamation mark.
*/
var hasValue: String?
hasValue = "A+"
print(hasValue)
print(hasValue!)
//:The above statements print the representation of an optional string and the value of `hasValue`.
//: > **Experiment**: Working with optionals and unwrapping optionals is a fundamental aspect of the Swift language. For this experiment, create a series of constants and variables each declared as non optional and optional and assign the non optional to the optional and vise versa. See if you can generate an error and then fix your issues.

/*:
### Nil Coalescing Operator
The `nil` coalescing operator is a shortcut statement to test if a variable is `nil` and to use a supplied default if it is `nil` or to automatically unwrap the optional if the constant or variable contains a value. The `nil` coalescing operator takes the form of `(a ?? b)`. The longer version to the `nil` coalescing operator uses the ternary conditional operator: `(a != nil) ? a! : b`.
*/
var couldBeNil: String?
var defaultValue = "Student"

print(couldBeNil ?? defaultValue)

couldBeNil = "Teacher"

print(couldBeNil ?? defaultValue)
print((couldBeNil != nil) ? couldBeNil! : defaultValue)
//: The above statements show the nil coalescing operator and longer form of the of the equivalent.
/*:
### The `if` statement and forced unwrapping
When working with optionals, you might not have knowledge if the optional has a value or it is valueless. Therefore, you need to using the `if` conditional statement to determine if you can unwrap the optional to access the value.
*/
var someOptional: Int?
someOptional = 5

if someOptional != nil {
    print("someOptional has a value of \(someOptional!)")
} else {
    print("someOptional is valueless")
}
//: Here we have a variable `someOptional` of type `Int?`, an optional int. Then we set the `someOptional` variable to `5` and print whether it has a value or it is valueless.
/*:
### Optional Binding
Having to check if an optional value has a value or is valueless can add noise to your program. Swift provides *optional binding* to reduce code amount of code you have to write to check if a optional has a value for you to use.
*/
if let constantName = someOptional {
    print("constantName has a value of \(constantName)")
} else {
    print("constantName is valueless")
}
//: Above we find out whether an `someOptional` contains a value, and if so, make that value available as a temporary constant. Optional binding can be used for `if` statements as well as `while` statements (`if` and `while` statements are explained in [Control Flow](Control%20Flow)).
//: > **Experiment**: 1) Create 1 optional string constant, and 1 optional string variable, initially both having a value. Use the `if` conditional statement and *optional binding* to print both values, else print that something is missing. 2) Set the optional string variable to `nil` and see what happends.

/*:
## Implicitly Unwrapped Optionals
Within your program, you will encounter statements where it is clear that an optional will always have a value. Having to check if the optional has a value and unwrap the optional isn't necessary because the optional will always have a value. These types of optionals are call *implicitly unwrapped optionals*, indicating so by placing a `!` instead of a `?` after the type. Implicitly unwrapped optionals are automatically unwrapped whenever it is used.
*/
var anotherOptional: String?
anotherOptional = "I'm a regular optional"

var nonOptional: String = anotherOptional! // force unwrap to access the value

var implicitlyUnwrapped: String! = "I'm an implicitly unwrapped optional"

anotherOptional = implicitlyUnwrapped // can be assigned to an optional
nonOptional = implicitlyUnwrapped // can be assigned to a non optional
//: Above we start out with a regular optional, `anotherOptional` and then assign it a value. Then we create a non optional `nonOptional` unwrapping `anotherOptional` to access the value and assign it to `nonOptional`. Next we create an *implicitly unwrapped optional* `implicitlyUnwrapped` and assign it to both `anotherOptional` and `nonOptional`.
//: > **Experiment**: Print the value of `anotherOptional` and `nonOptional`. Which one is optional? Notice that *implicitly unwrapped optional* can be assigned to either an optional type or an non optional type.

/*:
## Operators
Operators are symbols that execute specific operations on one, two, or three operands (targets) and provide a result. There are three types of operators, unary (operate on a single target), binary (operate on two targets), and ternary (operate on three targets). Please visit the Swift [Language Guide](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-ID60) and [Reference](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_StandardLibrary_Operators/index.html#//apple_ref/doc/uid/TP40016054) learn about the full list of operators available in Swift.
*/
/*:
## Unary Operators
Unary operators operate on one target. Only the increment (`++`) and decrement operators (`--`) can be placed before or after the target, but the side effects are different.
*/
/*:
### Increment and Decrement Operators
Operators such as the increment and decrement operators are shortcut operators for the binary binary operator of adding or subtracting 1 to a number. The increment and decrement operators can be placed before (a.k.a *prefix*) the target which will execute the operation before returning the result or after (a.k.a *postfix*) the target which will execute the operation after the result is returned.
*/
var i = 0
// increment prefix
print(++i)
// decrement postfix
print(i--)
print(i)
/*:
### Unary Minus Operators
Using the unary minus operator, you can switch the sign (positive or negative) of a number.
*/
var number = 5
-number
print(number)
-number
print(number)
/*:
### Unary Plus Operators
The unary Plus Operator returns the value it is currently operating on.
*/
print(+number)
/*:
### `!` Logical NOT Operator
The logical NOT operator is a unary operator as well as a logical operator. Placing the `!` operator directly in front of a boolean target will switch it's value to it's opposite boolean value, such as true -> false and false -> true.
*/
var boolean = true
!boolean
print(boolean)
print(!boolean)
/*:
## Binary Operators
As mentioned above, binary operators operate on two targets. Binary Operators are the most numerous of the operator types and consist of assignment, arithmetic, compound and comparison operators.
*/
/*:
### Assignment Operator
The assignment operator assigns and expression or literal value to a variable or constant.
*/
let number1 = 1
let aTrueValue = true
let string1 = "A String"
let string2 = string1
// Reread the **Tuples** section above to see how to use the assignment operator and tuples' special features.
/*:
### Arithmetic Operators
The arithmetic operator performs an arithmetic function on two targets, such as 2 + 2. Swift supports addition (+), subtraction (-), multiplication (*) and division (/). The addition (+) operator is also support on String values to perform appending one string onto another.
*/
let addition = 2 + 2
let subtraction = 2 - 2
let multiplication = 2 * 2
let division = 2 / 2
let helloStudent = "Hello " + "Student!"
//: > The **Remainder Operator** is another arithmetic operator that calculates now many times one numbers 'goes into' another and returns what is left over, known as the remainder. The remainder operator is the percentage symbol `%`
let remainder1 = 9 % 2
let remainder2 = -9 % 2
//: > **Experiment**: See if the remainder operator applies to floating point numbers.

/*:
### Compound Assignment Operators
Compound Assignment Operators combine the assignment operator with another operation. The most common compound assignment operators consist of arithmetic operators.
*/
var compound = 1
compound += 9
compound -= 5
compound *= 2
compound /= 10
/*:
### Comparison Operators
Operators that compare one target to another target such as `a < b` (a less then b) are comparison operators. Swift supports equal (`=`), not equal to (`!=`), greater than (`<`), less than (`<`), greater than or equal to (`>=`), and less than or equal to (`<=`).
*/
let a = 5
let b = 10

let equalTo = a == b
let notEqualTo = a != b
let greaterThan = a > b
let lessThan = a < b
let greaterThanOrEqualTo = a >= b
let lessThanOrEqualTo = a <= b
/*:
### Logical Operators
Swift supports two binary logical operators, the **logical AND operator** (`a && b`) and the **logical OR operator** (`a || b`). Logical operators change or combine the boolean logic values of true or false. Logical operators are typically used in the `if` statement to branch the execution of code towards 1 more move paths. The `if` statement will be introduced in [Control Flow](Control%20Flow).
*/
/*:
The **logical AND operator** (`a && b`) is an expression that evaluates to true of *both* `a` and `b` evaluate to true, otherwise the overall result is false. If `a` is false to being with, `b` is never evaluated since it's not necessary to evaluate `b`.
*/
var comesToClass = true
var doesAssignments = false

if comesToClass && doesAssignments {
    print("Gets a good grade.")
} else {
    print("Gets a D")
}

doesAssignments = true

if comesToClass && doesAssignments {
    print("Gets a good grade.")
} else {
    print("Gets a D")
}
/*:
The **logical OR operator** (`a || b`) is an expression that evaluates to true if *either* `a` or `b` evaluate to true, otherwise the overall result is false. If `a` is true to being with, `b` is never evaluated since it's not necessary to evaluate `b`.
*/
var studiesHard = false
var gifted = true

if studiesHard || gifted {
    print("Gets a good grade.")
} else {
    print("Gets a D")
}

studiesHard = true
gifted = false

if studiesHard || gifted {
    print("Gets a good grade.")
} else {
    print("Gets a D")
}
/*:
## Ternary Conditional Operator
The ternary operator is a unique operator that consists of three parts. *Part 1* needs to evaluate to a boolean, *part 2* is evaluated if *part 1* is true and *part 3* is evaluated if *part 1* is false. The ternary operator is a shortcut for the `if else` control flow logic that will be introduced in [Control Flow](Control%20Flow). The ternary conditional operator is useful for condensing a multi line `if else` into a single line statement.
*/
var booleanValue = true
var ternaryValue = booleanValue ? "yes" : "no"
ternaryValue = !booleanValue ? "yes" : "no"
/*:
## Range Operators
Range operators are a useful way to represent a range of values. Swift supports two range operators, 1) close range operator (`a...b`) and 2) half-open operator (`a..<b`). Range operators are typically used in the `for-in` loop, explained in more detail in the [Control Flow](Control%20Flow) section.
*/
/*:
### Closed Range Operator
The closed range operator `a...b` defines a range starting with `a`, includes all values up-to and including `b`. `a` must not be greater than `b`. It is considered 'closed' because both the start and end are included in the range.
*/
var showClosedRange = 0
for closedRangeIndex in 1...10 {
    showClosedRange++
}
print(showClosedRange)
/*:
### Half-Open Range Operator
The half-open range operator `a..<b` defines a range starting with `a`, includes all values up-to `b` but does not include `b`. `a` must not be greater than `b`. It is considered 'half-open' because only the start is included in the range.
*/
var showHalfOpenRange = 0
for halfOpenRangeIndex in 1..<10 {
    showHalfOpenRange++
}
print(showHalfOpenRange)
/*:
**Exercise:**
Your a big tipper! When ever you go out to eat you tip 20% of the bill and never tip less than $3. Create a playground that prints the tip amount and the total amount. Within the playground, you should be able to change the bill to see how the tip amount varies.
>> **Example Output:**
* `What is the bill? $x.xx`
* `What is the tip percentage? x`
* `The tip is $x.xx`
* `The total is $x.xx`
>> **Constraints:**
* Don't use the `String(format:, _, _)` initilizer
* Use the remainder operator while creating the string
* Use the ternary conditional operator
*/
/*:
**Checkpoint:**
At this point, you should be able to describe in detail the purpose of each data type and why it would be used within your programs. You also should be able to leverage tuples to group values together and work with operators on constants and variables. These building blocks will be used in the following chapters to create richer programs.
*/
/*:
**Keywords to remember:**
- `import` = tells the compiler to make available to my program a specified framework
- `let` = declare a constant, a value that will never change throughout the program
- `var` = declare a variable, a value that will vary throughout the program
- `true` = indicate that something is true
- `false` = indicate that something is false
- `typealias` = to give a more meaningful name to an already existing data type
- `nil` = assign a constant or variable as valueless
*/
/*:
**Supporting Chapters:**
- [About Swift](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/index.html)
- [A Swift Tour](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html)
- [The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html)
- [Basic Operators](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html)
- [The Basics: Optionals](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID330)
- [Video: Swift Playgrounds](https://developer.apple.com/videos/play/wwdc2014-408/)
- [Video: Authoring Rich Playgrounds](https://developer.apple.com/videos/play/wwdc2015-405/)
- [Video: Introduction to Swift](https://developer.apple.com/videos/play/wwdc2014-402/)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
