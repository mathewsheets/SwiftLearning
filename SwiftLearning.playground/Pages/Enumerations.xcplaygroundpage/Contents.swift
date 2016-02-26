/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Enumerations
*/
/*:
> **Session Overview:**
> Overview content here ....
*/
import Foundation
/*:
## Creating Enumerations

*/
enum Grade {
    case A
    case B
    case C
    case D
    case F
}

var mathGrade = Grade.B;

mathGrade = .A
/*:
## Switch & Enumerations

*/
switch mathGrade {
case .A: fallthrough
case .B: fallthrough
case .C:
    print("You can move on.")
case .D:
    print("You can not move on.")
default:
    break // this break is needed because all cases need a body
}
/*:
## Associated Values

*/
enum TimeOfStudy {
    case AM, PM
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
/*:
## Raw Values

*/
enum GradingScaleStr : String {
    case A = "A Grade"
    case B = "B Grade"
    case C = "C Grade"
    case D = "D Grade"
    case F = "F Grade"
}

let history = GradingScaleStr.A

print(history.rawValue)
/*:
### Implicitly Assigned

*/
enum GradingScaleNum : Int {
    case A = 1, B, C, D, F
}

let english = GradingScaleNum.B

print(english.rawValue)

//print(mathGrade.rawValue)
/*:
### Initializing

*/
let science = GradingScaleNum(rawValue: 2)

let gymGrade = 6

if let gym = GradingScaleNum(rawValue: gymGrade) {
    switch gym {
    case .A:
        print("You got \(GradingScaleStr.A.rawValue)")
    case .B:
        print("You got \(GradingScaleStr.B.rawValue)")
    case .C:
        print("You got \(GradingScaleStr.C.rawValue)")
    case .D: fallthrough
    case .F:
        print("You can not move on")
    }
} else {
    print("Invalid gym grade")
}
/*:
## Recursive Enumerations

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

count(Count.Forward(Count.Number(1), Count.Number(10))) { (number) in
    
    print("forward to \(number)")
}
count(Count.Backward(Count.Number(10), Count.Number(1))) { (number) in
    
    print("backward from \(number)")
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
- `enum` = defines an Enumeration
- `indirect` = enables an Enumeration to be used recursively
*/
/*:
**Supporting Chapters:**
- [Enumerations](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html)
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
