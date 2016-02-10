/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Control Flow
*/
/*:
**Session Overview:**
Processing logic is what gives your programs personality. These decision making statements are known as control flow. Control flow statements can fork your execution path or even repeat a series of statements. Please visit the Swift Programming Language Guide section on [Control Flow](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html#//apple_ref/doc/uid/TP40014097-CH9-ID120) for more details on control flow.
*/
import Foundation
/*:
## The `if` and the `else` conditional statements
The simplest of the control flow statements is the `if` and `else` statements. The `if` conditional statement evaluates a boolean expression (true or false) and executes code if the result of the evaluation is `true`. If `else` is present, code is executed if the `if` statement evaluates to `false`.
*/
var grade = "A"

if grade == "A" {
    print("you will get an A")
} else {
    print("not an A")
}

grade = "D"

if grade == "D" {
    print("you will get a D")
} else {
    print("at least not a D")
}
//: You can also combine as many boolean expression on a `if` conditional statement, though using a `switch` statement if recommended for readabiliy.
if grade == "A" || grade == "B" {
    print("you will get a good grade")
} else if grade == "A" {
    print("you will get an average grade")
} else if grade == "D" || grade == "F" {
    print("you will get a bad grade")
}
/*:
## less `if`ing and more `switch`ing
If your code has many boolean expressions to evaluate, a `switch` statement will provide more readabiliy. The `switch` compares a value of a constant or variable against a series of possible outcomes. If there is a match, provide with the `case`, the block of code is executed for the `case` only. The `switch` statement must be *exhaustive*, meaning that every possible value must be matched against one of the `switch` cases.
*/
grade = "B"

switch grade {
case "A":
    print("get an A")
case "B":
    print("get an B")
case "C":
    print("get an C")
case "D":
    print("get an D")
default:
    print("get an F")
}

switch grade {
case "A", "B":
    print("pass")
case "D", "F":
    print("repeat")
default:
    print("needs to study more")
}
//: The above `switch` statements has the `default` case which will be matched when all other cases fail.
/*:
### Fallthrough
Swift's `switch` statement matches on a single case and ends execution of the `switch` after the case body is executed. There are instances where you would want multiple cases to be matched where it's not appropriate provide the matching on the a single case.
*/
var gradeNumber = 95
var gradeLetter: String = ""
switch gradeNumber {
case 93: fallthrough
case 94: fallthrough
case 95: fallthrough
case 96: fallthrough
case 97: fallthrough
case 98: fallthrough
case 99:
    gradeLetter = "A"
case 90:
    gradeLetter = "A-"
case 80:
    gradeLetter = "B"
case 70:
    gradeLetter = "C"
case 60:
    gradeLetter = "D"
case 50:
    gradeLetter = "F"
default:
    break // this break is needed because all cases need a body
}
print(gradeLetter)
//: `fallthrough` doesn't check the following case condition, but causes execution to move to the next statements of the following case.
//: > **Experiment**: Assign gradeNumber equal to 100 and have gradeLetter print A+.

/*:
### Interval Matching
The value in the `switch` case statement can be checked to determine if the value is included in a specified range.
*/
gradeNumber = 100
switch gradeNumber {
case 100:
    gradeLetter = "A+"
case 93...99:
    gradeLetter = "A"
case 90..<93:
    gradeLetter = "A-"
case 80..<90:
    gradeLetter = "B"
case 70..<80:
    gradeLetter = "C"
case 60..<60:
    gradeLetter = "D"
case 50..<60:
    gradeLetter = "F"
default:
    gradeLetter = ""
    break // this break is needed because all cases need a body
}
print(gradeLetter)
/*:
The above `switch` case uses grade ranges to determine the grade letter as opposed to specifying each grade number.
*/
/*:
### Working with Tuples
Using the `switch` statement with tuples lets you execute code branches depending on values within the tuple.
*/
let gradeTuple = (gradeNumber, gradeLetter)

switch gradeTuple {
case (100, _):
    print("You get an A+")
case (93...99, _):
    print("You get an A")
case (90..<93, _):
    print("You get an A-")
case (80..<90, _):
    print("You get an B")
case (70..<80, _):
    print("You get an C")
case (60..<60, _):
    print("You get an D")
case (50..<60, _):
    print("You get an F")
default:
    print("You got an \(gradeTuple.0)%")
}

switch gradeTuple {
case (_, "A+"):
    print("You got 100%")
case (_, "A"):
    print("You got between 90% - 99%")
case (_, "B"):
    print("You got between 80% - 89%")
case (_, "C"):
    print("You got between 70% - 79%")
case (_, "D"):
    print("You got between 60% - 69%")
case (_, "F"):
    print("You got between 50% - 59%")
default:
    print("You dont' get a grade")
}
/*:
The first `switch` case statement matches on the grade number providing that the grade number falls within a case range. The second `switch` matches on the grade letter.
*/
/*:
### Value Bindings
The `switch` case statement can store values into constants or variables that are only available to the `switch` case body. This is known as *value binding*, because values are bound to temporary constants or variables when a value or values are match in the case.
*/
switch gradeTuple {
case (90...100, let letter):
    print("You got between 90% - 100%, or an \(letter)")
case (80..<89, let letter):
    print("You got between 80% - 89%, or a \(letter)")
case (70..<79, let letter):
    print("You got between 70% - 79%, or a \(letter)")
case (60..<69, let letter):
    print("You got between 60% - 69%, or a \(letter)")
case (50..<59, let letter):
    print("You got between 50% - 59%, or a \(letter)")
case let (number, letter):
    print("You got a \(number)% or a \(letter)")
}
/*:
Here the `switch` matches on the grade number range and prints out the grade letter.
*/
/*:
### Where
You can use a `where` clause to check for even more conditions.
*/
switch gradeTuple {
case (100, _):
    print("You aced it!")
case let (number, letter) where "ABCD".containsString(letter):
    print("You passed!")
default:
    print("You failed!")
}
/*:
Above, all we want to do is print a message from one of three cases. We use the `where` clause on the second case to see if the grade letter is contained in the array of grade letters.
*/
/*:
## Iterating using For Loops
Two `for` looping statements that let you execute code blocks a certain number of times are the `for-in` and the `for` loops.
*/
/*:
### For-In
The `for-in` loop executes a set of statements for each item in a list or sequence of items.
*/
for grade in "ABCDF".characters {
    print(grade)
}

for index in 0..<5 {
    print(index)
}
/*:
### For
The `for` loop executes a set of statements until a specific condition is met, usually by incrementing a counter each time the loop ends.
*/
for var index = 0; index < 5; ++index {
    print(index)
}
//: The `for` loop has 3 parts:
/*:
- *Initialization* (`var index = 0`), evaluated once.
- *Condition* (`index < 5`), evaluated at the start of the each loop. If the result is `true` statements in the block are executed, if `false` the loop ends.
- *Increment* (`++index`), evaluated after all the statements in the block are executed.
*/
/*:
## Iterating using While Loops
`while` loops are recommended when the number of iterations is unknown before looping begins.
*/
/*:
### While
The `while` loop evaluates its condition at the beginning of each iteration through the loop.
*/
var index = 0
while (index < 5) {
    
    print(index)
    index++
}
//: The above `while` loop statement evaluates `index < 5`, if the result is `true` looping continues, if `false` looping ends.
/*:
### Repeat-While
The `repeat-while` loop evaluates its condition at the end of each iteration through the loop.
*/
index = 0
repeat {

    print(index)
    index++
} while (index < 5)
//: The above `repeat-while` loop statement executes the code block first then evaluates `index < 5`, if the result is `true` looping continues, if `false` looping ends.
/*:
## Control Transfer Statements
Control transfer statements change the sequence or order in which your code is executed, by transferring control from one block of code to another. Swift provides five control transfer statements:
- `continue`
- `break`
- `fallthrough`
- `return`, explained in [Functions](Functions)
- `throw`, explained in [Functions](Functions)
*/
/*:
### Continue
The `continue` statement tells a loop to stop and start again at the beginning of the next iteration through the loop.
*/
index = 0
repeat {
    
    index++
    
    if index == 3 {
        continue
    }
    
    print(index)
    
} while (index < 5)
//: The above `repeat-while` loop statement skips the index 3, moves onto the next iteration of the loop printing 4 and 5, then ends normally.
/*:
### Break
The `break` statement ends the execution of the control flow statement. The `break` statement is used in the `switch` and loop statements to end the control flow earlier than normal.
*/
/*:
**Break in a Loop Statement**
A `break` in a loop exits the loop.
*/
index = 0
repeat {
    
    index++
    
    if index == 3 {
        break
    }
    
    print(index)
    
} while (index < 5)
//: The above `repeat-while` loop statement loops until index equals 3 and exits the loop all together.
/*:
**Break in a Switch Statement**
A `break` in a `switch` is used to ignore cases.
*/
gradeNumber = 80
switch gradeNumber {
case 100:
    print("A+")
case 90:
    print("A")
case 80:
    print("B")
case 70:
    print("C")
case 60:
    print("D")
case 50:
    print("F")
default:
    break // this break is needed because all cases need a body
}
//: The above `switch` statement needs a `break` in the `default` case because the all other values greater than 100 aren't applicable.
/*:
## API Availability

*/
if #available(iOS 9, OSX 10.11, *) {
    print("statements will execute for iOS9+ and osx 10.11+")
} else {
    print("statements to execute when running on lower platforms.")
}
/*:
**Exercise:** You have a secret message to send. Write a playground that can encrypt strings with an alphabetical [caesar cipher](https://en.wikipedia.org/wiki/Caesar_cipher). This cipher can ignore numbers, symbols, and whitespace.
>> **Example Output:**
* Decrypted: Nearly all men can stand adversity, but if you want to test a man's character, give him power
* Encrypted: arneyl nyy zra pna fgnaq nqirefvgl, ohg vs lbh jnag gb grfg n zna'f punenpgre, tvir uvz cbjre
>> **Constraints:**
* The encrypted and decrypted text is case sensitive
* Add a shift variable to indicate how many places to shift
*/
/*:
**Checkpoint:**
At this point, you have learned the majority of the control flow statements that enable you to make decisions and execute a set of statements zero or more times until some condition is met.
*/
/*:
**Keywords to remember:**
- `if` = evaluate an express for `true` and execute the following statements
- `else` = execute the following statements when the `if` evaluates an express to false
- `for` = to iterate
- `in` = when used with `for`, iterate over items in *something*
- `while` = execute statements indefinitely until a false expression is met
- `repeat` = used with `while`, execute statments first then loop
- `switch` = the start of matching a value on possible outcomes
- `case` = used with `switch`, a single outcome
- `default` = used with 'switch', the any outcome
- `fallthrough` = used with `switch`, execute the next case's statements
- `continue` = move on to the next iteration and don't execute the following statements
- `break` = when used with looping, stop looping and don't execute the following statements
- `where` = when used with switch, to expand matching conditions
*/
/*:
**Supporting Chapters:**
- [Control Flow](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ControlFlow.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
