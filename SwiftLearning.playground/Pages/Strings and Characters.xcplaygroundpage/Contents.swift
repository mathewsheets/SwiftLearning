/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
/*:
# Strings & Characters
*/
/*:
**Session Overview:**
Strings are one of Swift's fundamental types that stores a series of characters such as "Hello Student". In this session we will go into more detail about `String`'s capabilities and learn what properties and functions that are available. Please refer to the Swift Language Guide section [Strings and Characters](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285) and also the [String](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_String_Structure/index.html#//apple_ref/swift/struct/s:SS) data type in the Swift Standard Library Reference to read even more about Swift's String data type.
*/
import Foundation
/*:
## Initializing
There are two way to create a `String`. You can create a `String` by using a string literal such as "Hello Again", or by appending parenthese at the end of String such as `String()`
*/
let stringEmptyLiteral = ""
var stringEmptyInstance = String()
//: Both statements above create strings that initialized the storage to an empty string.
let stringLiteral = "I'm a literal"
var stringInstance = String("I'm an instance")
//: Both statements above create strings that initialized the storage to actual string value.
let stringInterpolation = "\(stringLiteral) and \(stringInstance)"
//: The above statement creates a string that initialized the storage using string interpolation.
/*:
## When you're allowed to change or *mutate* a `String`
In some cases, you need to keep the contents of the `String` unchanged throughout the entire program. Also, there are cases where you would like to change the contents of the `String`, such as appending additional text. You indicate this by selecting the correct keyword of either `let` (constant) or `var` (variable).
*/
let stringCannotBeChanged = "I can't be changed."
//stringCannotBeChanged += " I want to add more" // -> uncomment to see what the compile error is

var stringCanBeChanged = String("I can be changed.")
stringCanBeChanged += " I want to add more"
//: > When we use the word *instance*, think of it as owning a copy (`String` in this context) of a data type, but your copy could be different because of the way you initialized it or mutated it. When working with `String`s, we create instances of the `String` data type and available to us are properties (attributes) and methods (behavior).
let quote = "Give me six hours to chop down a tree and I will spend the first four sharpening the axe."
var quote2 = "Better to remain silent and be thought a fool than to speak out and remove all doubt."
let quote3 = "Nearly all men can stand adversity, but if you want to test a man's character, give him power."
/*:
## Instance Properties
All Strings have attributes called properties that provide you the ability to retrieve information about an instance of a String.
*/
//: **About String Indices**

//: Use `startIndex` to get the index of the starting position of a String.
print("The start index is \(quote.startIndex)")
//: Use `endIndex` to get the index of the ending position of a String.
print("The start index is \(quote.endIndex)")
//: Use `isEmpty` to determine if a String has a value.
print("The string is empty? = \(quote.isEmpty)")

let anotherQuote = ""

print("The string is empty? = \(anotherQuote.isEmpty)")
//: Use `lowercaseString` to convert all characters in the String to lowercase.
print(quote.lowercaseString)
//: Use `uppercaseString` to convert all characters in the String to uppercase.
print(quote.uppercaseString)
//: The `characters` property provides access to the list of characters in a String. Use the `characters.count` to get the count of number of characters in a String.
print("Quote has \(quote.characters.count) characters")
/*:

## Instance Methods
All Strings have methods that allow you to interact with a String, such as adding to, removing from, replacing within, checking for the existence of other characters of Strings, and finding substrings from based on indexes or ranges.
*/
/*:
### Adding to a String
You can create a new String by concatenating multiple strings together or change the contents within a String by using either append or insert.
*/
//: Use `+` the plus symbol to add or concat multiple string together
let quoteFirstHalf = "Give me six hours to chop down a tree"
let quoteSecondHalf = "and I will spend the first four sharpening the axe"
var quoteFull = quoteFirstHalf + " " + quoteSecondHalf

print(quoteFull)
//: Use `append` to add a character to the end of a string.
var give = "G"
var charI: Character = "i"
var charV: Character = "v"
var charE: Character = "e"
give.append(charI)
give.append(charV)
give.append(charE)

print(give)
//: Use `insert` to add a character at the specified index.
give.insert("!", atIndex: give.endIndex)

print(give)
//: Use `insertContentsOf` to add the characters of a String at the specified index.
give.insertContentsOf(" me six hours".characters, at: give.startIndex.advancedBy(5))

print(give)
/*:
### Removing from a String
You can also remove characters or a range of characters within a String.
*/
//: Use `removeAll` to remove all characters from a String
quote2.removeAll();

print(quote2)

quote2 += "Better to remain silent and be thought a fool than to speak out and remove all doubt."
//: Use `removeAtIndex` to remove a character at the specified index.
quote2.removeAtIndex(quote2.endIndex.predecessor())

print(quote2)
//: Use `removeRange` to remove characters using the specified range.
let range = quote2.endIndex.advancedBy(-6)..<quote2.endIndex

quote2.removeRange(range)

print(quote2)
/*:
### Replacing content in a String
You can replace a portion of a String with another Character or String.
*/
let range2 = quote2.endIndex.advancedBy(-39)..<quote2.endIndex.advancedBy(-38)

quote2.replaceRange(range2, with: "A")

print(quote2)
/*:
### Checking for values
You can check if a String starts with (prefix) or ends with (Suffix) a String.
*/
let startsWith = quote2.hasPrefix("Better");

print(startsWith)

let endsWith = quote2.hasSuffix("doubt!")

print(endsWith)
/*:
### Finding Substrings
You can find Strings contained in other Strings, also known as substrings.
*/
//: Use `substringFromIndex` to get a substring starting with an index
let giveHimPower = quote3.substringFromIndex(quote3.endIndex.advancedBy(-15))

print(giveHimPower)
//: Use `substringToIndex` to get a substring up to the index
let adversity = quote3.substringToIndex(quote3.startIndex.advancedBy(34))

print(adversity)
//: Use `substringWithRange` to based off of a range
let test = quote3.substringWithRange(quote3.startIndex.advancedBy(55)..<quote3.endIndex.advancedBy(-17))

print(test)

/*:
**Exercise:**
>> **Example Output:**
* `My name is Mathew Sheets`
*/
/*:
**Experiment**: Get the names of each member in the class.
- Create a String starting with your name
- Add each student's name to the String
- Select a student and remove their name
- Select a student and uppercase their name
- Select 2 students and find their names
- From the String of 2 students, see if the String starts with and ends with the student's name from the above step
*/
/*:
**Checkpoint:**
At this point, ...
*/
/*:
[Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
*/
