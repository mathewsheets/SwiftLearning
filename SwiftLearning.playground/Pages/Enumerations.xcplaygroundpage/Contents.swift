/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Enumerations
 * callout(Session Overview):
 An enumeration is a type-safe way to group related values. These values would typically be an `Int` that outside the context of the enumeration, would become ambiguous. Enumerations in swift are far more rich in functionality when compared to other languages.
*/
import Foundation
/*:
## Creating Enumerations
Enumerations are created with the keyword `enum` and the `case`s are placed in the pair of braces.
*/
enum Grade {
    case A
    case B
    case C
    case D
    case F
}

var mathGrade = Grade.B

mathGrade = .A

print(mathGrade)
/*:
Above we created a `Grade` enumeration with cases of `A`, `B`, `C`, `D` and `F`. We can assign a `Grade` enumeration with a dot syntax with the enumeration before the dot and the case after the dot. Or, using Swift's type inference we can just use the dot preceding the case.
*/
/*:
## Switch & Enumerations
You can use enumerations with `switch-case` statements.
*/
switch mathGrade {
case .A: fallthrough
case .B: fallthrough
case .C:
    print("You can move on.")
case .D: fallthrough
case .F:
    print("You can not move on.")
}
/*:
Above we use a `switch` and multiple `case` statements to match on `mathGrade`. We can also use type inference to match on to make our code less verbose. Note also that `swith-case` statements need to be exhaustive, meaning we must provide a case on which `mathGrade` needs to match. We always have the `default` case to match on `case`s where we don't want to handle explicitly.
*/
/*:
## Associated Values
Enumerations in Swift provide the capabiliy to store other information, called associated values along with the case value.
*/
enum TimeOfStudy {
    case AM
    case PM
}

enum HoursStudying {
    case OneTwo(String)
    case ThreeFive(String)
    case SixPlus(String, TimeOfStudy)
}

let studying = HoursStudying.SixPlus("7", TimeOfStudy.AM)

switch studying {
case let .OneTwo(hours):
    print("You spent \(hours) hours studying, in the 1 to 2 hours range")
case let .ThreeFive(hours):
    print("You spent \(hours) hours studying, in the 3 to 5 hours range")
case .SixPlus(let hours, let time):
    print("You spent \(hours) hours studying, in the 6+ hours range, mostly in the \(time)")
}

if case let HoursStudying.SixPlus(hours, time) = studying {
    print("You spent \(hours) hours studying, in the 6+ hours range, mostly in the \(time)")
}
/*:
Above we create an enumeration `TimeOfStudy` with cases `AM` and `PM`. We also create an enumeration `HoursStudying` with cases of `OneTwo`, `ThreeFive`, `SixPlus`. Notice that each case looks like it has parameters. These values are the associated values which can be extracted in a `switch-case` statement. You can also use pattern matching with an if-let to extract the values.
*/
/*:
## Raw Values
Enumerations in Swift can also store raw values of types `Int`, `String`, `Character`, or one of the floating point numbers.
*/
enum GradingScale : String {
    case A = "A Grade"
    case B = "B Grade"
    case C = "C Grade"
    case D = "D Grade"
    case F = "F Grade"
}

print(GradingScale.A.rawValue)
/*:
Above we created an enumeration that stores `String`s as a raw value. You can access the raw value by using `rawValue` after the enumeration case.
*/
/*:
### Implicitly Assigned
Swift will also implicitly assign values to enumerations of type `Int` and `String`
*/
enum GradeNumber : Int {
    case A = 1, B, C, D, F
}

print(GradeNumber.B.rawValue)

enum GradeLetter: String {
    case A, B, C, D, F
}

print(GradeLetter.B.rawValue)
/*:
Above we have two enumerations. `GradeNumber` of type `Int` and `GradeLetter` of type `String`. `GradeNumber`, being an `Int`, starting with `A = 1`, `case B` will have a value of implicitly assigned to equal `2` and so on with `case C` and continuing on. `GradeLetter` has an value implicitly assigned equal to the case value itself.
*/
/*:
### Initializing
When declaring enumerations that accept raw values, an initializer is automatically created. The initializer has a parameter called `rawValue` and returns an optional. The initializer returns an optional because the value that you can pass could be an invalid value for the case.
*/
let scienceGrade = GradeNumber(rawValue: 2)

print(scienceGrade)

let gymGrade = GradeNumber(rawValue: 6)

if let gym = gymGrade {
    switch gym {
    case .A: fallthrough
    case .B: fallthrough
    case .C:
        print("You can move on")
    case .D: fallthrough
    case .F:
        print("You can not move on")
    }
} else {
    print("Invalid gym grade")
}
/*:
Above we declare a constant `scienceGrade` using the initializer passing `2` as the `rawValue`. This initializer is able to return an optional of type `GradeNumber` enumeration. Next we declare a constant `gymGrade` using the initializer passing 6, an invalid value for enumeration `GradeNumber`. We can use `if let` binding and a `switch-case` statement to match on a case to print the appropriate text.
*/
/*:
## Recursive Enumerations
Swift provides the capability to create an enumeration that has another instance of the same enumeration type as the associated value for one or more of the enumeration cases. This particular type of enumeration is called a recursive enumeration.
*/
indirect enum Count {
    case Number(Int)
    case Forward(Count, Count)
    case Backward(Count, Count)
}

func count(counting: Count, closure: (number: Int) -> Void) -> Int {

    switch counting {
    case .Number(let number):
        return number
    case let .Forward(from, to):
        let fromNum = count(from, closure: closure)
        let toNum = count(to, closure: closure)

        if(fromNum <= toNum) {
            closure(number: fromNum)

            return count(Count.Forward(Count.Number(fromNum + 1), to), closure: closure)
        }
    case let .Backward(from, to):
        let fromNum = count(from, closure: closure)
        let toNum = count(to, closure: closure)

        if(fromNum >= toNum) {
            closure(number: fromNum)

            return count(Count.Backward(Count.Number(fromNum - 1), to), closure: closure)
        }
    }

    return 0
}

count(Count.Forward(Count.Number(1), Count.Number(10))) { print("forward to \($0)") }
count(Count.Backward(Count.Number(10), Count.Number(1))) { print("backward from \($0)") }
/*:
Above we have an enumeration called `Count`. `Count` has three `case`s with each accepting an associated value. `case Forward` and `case Backward` accept an associated value of `Count`. Using the `indirect` keyword preceding the `enum` indicates that we intend to use itself as an associated value. Next we create a function called `count` with parameters of type `Count` and a closure `(Int) -> Void`. The `count` function recursively calls itself until the first `Count` number equals the second `Count` number.
*/
/*:
**Exercise:** We need to model the set of possible iPhones manufactured. Replace each possible tuple property value with an enumeration that would be appropriate to the current non enumeration value.
*/
let iPhone          = (modelName: "iPhone", modelNumbers: ["A1203"], hardwareStrings: ["iPhone1,1"], osVersions: [1, 2, 3])
let iPhone3G        = (modelName: "iPhone 3G", modelNumbers: ["A1324", "A1241"], hardwareStrings: ["iPhone1,2"], osVersions: [2, 3, 4])
let iPhone3Gs       = (modelName: "iPhone 3Gs", modelNumbers: ["A1325", "A1303"], hardwareStrings: ["iPhone2,1"], osVersions: [3, 4, 5, 6])
let iPhone4         = (modelName: "iPhone 4", modelNumbers: ["A1349", "A1332"], hardwareStrings: ["iPhone3,1", "iPhone3,2", "iPhone3,3"], osVersions: [4, 5, 6, 7])
let iPhone4s        = (modelName: "iPhone 4s", modelNumbers: ["A1431", "A1387"], hardwareStrings: ["iPhone4,1"], osVersions: [5, 6, 7, 8, 9])
let iPhone5         = (modelName: "iPhone 5", modelNumbers: ["A1428", "A1429", "A1442"], hardwareStrings: ["iPhone5,1", "iPhone5,2"], osVersions: [6, 7, 8, 9])
let iPhone5c        = (modelName: "iPhone 5c", modelNumbers: ["A1532", "A1456", "A1507", "A1529"], hardwareStrings: ["iPhone5,3", "iPhone5,4"], osVersions: [7, 8, 9])
let iPhone5s        = (modelName: "iPhone 5s", modelNumbers: ["A1533", "A1453", "A1457", "A1530"], hardwareStrings: ["iPhone6,1", "iPhone6,2"], osVersions: [7, 8, 9])
let iPhone6         = (modelName: "iPhone 6", modelNumbers: ["A1549", "A1586"], hardwareStrings: ["iPhone7,2"], osVersions: [8, 9])
let iPhone6Plus     = (modelName: "iPhone 6 Plus", modelNumbers: ["A1522", "A1524"], hardwareStrings: ["iPhone7,1"], osVersions: [8, 9])
let iPhone6s        = (modelName: "iPhone 6s", modelNumbers: ["A1633", "A1688"], hardwareStrings: ["iPhone8,1"], osVersions: [9])
let iPhone6sPlus    = (modelName: "iPhone 6s Plus", modelNumbers: ["A1634", "A1687"], hardwareStrings: ["iPhone8,2"], osVersions: [9])

let phones = [iPhone, iPhone3G, iPhone3Gs, iPhone4, iPhone4s, iPhone5, iPhone5c, iPhone5s, iPhone6, iPhone6Plus, iPhone6s, iPhone6sPlus]
/*:
>> **Constraints:**
* Create the following Enumerations:
    * ModelName = Enumeration for all the model names
    * ModelNumber = Enumeration for all the model numbers
    * HardwareString = Enumeration for all hardware string
    * OSVersion = Enumeration for all os versions
* Create the following Functions
    * Create a device passing in as arguments each enumeration
        * Validate the parameters using a guard statement
        * Throw an error that's appropriate to the invalid parameter value
        * Return a tuple similar to above only using the above enumerations
    * Get Device with ModelName
    * Get Device with ModelNumber
    * Get Device with HardwareString
    * Get Devices with OSVersion
*/
/*:
**Checkpoint:**
At this point, you should have an good understanding of how to create enumerations with associated and raw values and also how to leverage `switch-case` statements to match a constant or variable on the possible cases and extract the values from the enumeration. You also learned about recursive enumerations providing the ability to have a case that accepted as an associated value of the same enumeration type.
*/
/*:
 - important: Keywords to remember:
 - `enum` = defines an Enumeration
 - `indirect` = enables an Enumeration to be used recursively
 * callout(Supporting Materials): Chapters and sections from the Guide and Vidoes from WWDC
 - [Guide: Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
