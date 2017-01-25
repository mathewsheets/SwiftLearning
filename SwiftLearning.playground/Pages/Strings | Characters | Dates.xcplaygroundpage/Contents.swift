/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Strings & Characters & Dates
 * callout(Session Overview): Strings are one of Swift's fundamental data types that stores a series of characters such as "Hello Student". In this session we will go into more detail about `String`'s capabilities and learn what properties and methods that are available. Please refer to the Swift Language Guide section [Strings and Characters](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285) and also the [String](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_String_Structure/index.html#//apple_ref/swift/struct/s:SS) data type in the Swift Standard Library Reference to read more about Swift's Strings. Dates are a structured series of numbers and characters that represent a date and time. With a `Date` you can perform date arithmetic and represent a day and time within your program.
 */
import Foundation
/*:
 # `String`s
 ## Creating
 There are two way to create a `String`. You can create a `String` by using a string literal such as "Hello Again", or by appending parenthese at the end of String such as `String()`
 */
let stringEmptyLiteral = ""
var stringEmptyInstance = String()
//: Both statements above create strings that initialized the storage to an empty string.
let stringLiteral = "I'm a literal"
var stringInstance = String("I'm an not a literal")
//: Both statements above create strings that initialized the storage to actual string value.
//: - experiment: Find out what are other ways to create a `String`

let stringInterpolation = "\(stringLiteral) and \(stringInstance)"
//: The above statement creates a string that initialized the storage using string interpolation.
/*:
 ## When you're allowed to change or *mutate* a `String`
 In some cases, you need to keep the contents of the `String` unchanged throughout the entire program. Also, there are cases where you would like to change the contents of the `String`, such as appending additional text. You indicate this by selecting the correct keyword of either `let` (constant) or `var` (variable).
 */
let stringCannotBeChanged = "I can't be changed."
//stringCannotBeChanged += " I want to add more" // -> uncomment to see what the compile error is

var stringCanBeChanged = "I can be changed."
stringCanBeChanged += " I want to add more"
//: > When we use the word *instance*, think of it as owning a copy (`String` in this context) of a data type, but your copy could be different because of the way you initialized it or mutated it. When working with `String`s, we create instances of the `String` data type and available to us are properties (attributes) and methods (behavior).
let abeQuote  = "Give me six hours to chop down a tree and I will spend the first four sharpening the axe."
var abeQuote2 = "Better to remain silent and be thought a fool than to speak out and remove all doubt."
let abeQuote3 = "Nearly all men can stand adversity, but if you want to test a man's character, give him power."
/*:
 ## Instance Properties
 All Strings have attributes called properties that provide you the ability to retrieve information about an instance of a String.
 Use `isEmpty` to determine if a String has a value.
 */
print("The string is empty? = \(abeQuote.isEmpty)")

let anotherQuote = ""

print("The string is empty? = \(anotherQuote.isEmpty)")
//: The `characters` property provides access to the list of characters in a String. Use the `characters.count` to get the count of number of characters in a String.
print("Quote has \(abeQuote.characters.count) characters")
//: Use `startIndex` to get the index of the starting position of a String.
let startIndex = abeQuote.startIndex
print("The start index is \(startIndex)")
//: Use `endIndex` to get the index of the ending position of a String.
let endIndex = abeQuote.endIndex
print("The endIndex index is \(endIndex)")
//: ## Instance Methods
//: All Strings have methods that allow you to interact with a String, such as adding to, removing from, replacing within, checking for the existence of other characters of Strings, and finding substrings from based on indexes or ranges.
//: Use `lowercased()` to convert all characters in the String to lowercase.
print(abeQuote.lowercased())
//: Use `uppercased()` to convert all characters in the String to uppercase.
print(abeQuote.uppercased())
/*:
 ### Traversing
 TEXT
 */
//:
abeQuote[abeQuote.index(after: startIndex)]
//:
abeQuote[abeQuote.index(before: endIndex)]
//:
abeQuote[abeQuote.index(startIndex, offsetBy: 1)]
//:
abeQuote[abeQuote.index(endIndex, offsetBy: -4)]
//:
if let index = abeQuote.index(startIndex, offsetBy: 4, limitedBy: endIndex) {
    abeQuote[index] // "o"
}
//:
let matchedIndex = abeQuote.characters.index(of: "s")
let nomatchIndex = abeQuote.characters.index(of: "Z")
//:
let distance = abeQuote.distance(from: abeQuote.startIndex, to: abeQuote.index(endIndex, offsetBy: -6))
/*:
 ### Ranges
 TEXT
 */
let url = "www.cscc.edu";
let urlEndIndex = url.endIndex
let tldStartIndex = url.index(urlEndIndex, offsetBy: -3)

let tldRange = Range(uncheckedBounds: (lower: tldStartIndex, upper: urlEndIndex))
print(url[tldRange])

let endOfDomain = url.index(url.endIndex, offsetBy: -4)
let rangeOfDomain = url.startIndex ..< endOfDomain
print(url[rangeOfDomain])

if let rangeOfTLD = url.range(of: "edu") {
    print(url[rangeOfTLD])
}
/*:
 ### Adding to a String
 You can create a new String by concatenating multiple strings together or change the contents within a String by using either append or insert.
 */
//: Use `+` the plus symbol to add or concat multiple string together
let quoteFirstHalf = "Give me six hours to chop down a tree"
let quoteSecondHalf = "and I will spend the first four sharpening the axe"

let quoteFull = quoteFirstHalf + " " + quoteSecondHalf
print(quoteFull)

var quoteFull2 = quoteFirstHalf
quoteFull2 += " " + quoteSecondHalf // also allowd to use the compound assignment add operator
print(quoteFull2)

print(quoteFull == quoteFull2)
//: Use `append` to add a `Character` to the end of a string.
var give = "G"
var charI: Character = "i"
var charV: Character = "v"
var charE: Character = "e"
give.append(charI)
give.append(charV)
give.append(charE)
print(give)
//: Use `insert` to add a character at the specified index.
give.insert("!", at: give.endIndex)
print(give)
//: Use `insertContentsOf` to add the characters of a String at the specified index.
give.insert(contentsOf: " me six hours".characters, at: give.index(give.startIndex, offsetBy: 5))
print(give)


/*:
 ### Removing from a String
 You can also remove characters or a range of characters within a String.
 */
//: Use `removeAll` to remove all characters from a String
abeQuote2.removeAll();

print(abeQuote2)

abeQuote2 += "Better to remain silent and be thought a fool than to speak out and remove all doubt."
//: Use `remove(at:)` to remove a character at the specified index.
abeQuote2.remove(at: abeQuote2.index(before: abeQuote2.endIndex))

print(abeQuote2)
//: Use `removeRange` to remove characters using the specified range.
let range = abeQuote2.index(abeQuote2.endIndex, offsetBy: -6)..<abeQuote2.endIndex

abeQuote2.removeSubrange(range)

print(abeQuote2)
//: ### Replacing content in a String
//: You can replace a portion of a String with another Character or String.
let range2 = abeQuote2.index(abeQuote2.endIndex, offsetBy: -39)..<abeQuote2.index(abeQuote2.endIndex, offsetBy: -38)

abeQuote2.replaceSubrange(range2, with: "A")

print(abeQuote2)
//: - experiment: Find out what other replace methods exist for a String.

/*:
 ### Checking for values
 You can check if a String starts with (Prefix) or ends with (Suffix) a String.
 */
let startsWith = abeQuote2.hasPrefix("Better");

print(startsWith)

let endsWith = abeQuote2.hasSuffix("doubt!")

print(endsWith)
/*:
 ### Finding Substrings
 You can find Strings contained in other Strings, also known as substrings.
 */
//: Use `substring(from:)` to get a substring starting with an index
let giveHimPower = abeQuote3.substring(from: abeQuote3.index(abeQuote3.endIndex, offsetBy: -15))

print(giveHimPower)
//: Use `substring(to:)` to get a substring up to the index
let adversity = abeQuote3.substring(to: abeQuote3.index(abeQuote3.startIndex, offsetBy: 34))

print(adversity)
//: Use `substring(with:)` to get a substring based off of a range
let test = abeQuote3.substring(with: abeQuote3.index(abeQuote3.startIndex, offsetBy: 55)..<abeQuote3.index(abeQuote3.endIndex, offsetBy: -17))
print(test)
//: - - -
//: # `Date`s
//: Read [Date](https://developer.apple.com/reference/foundation/nsdate) data type in the Swift Standard Library Reference to read more about Swift's Dates.
//: ## Creating
let now = Date();
print(now)

let nowPlus20Seconds1 = Date(timeIntervalSinceNow: 20)
print(nowPlus20Seconds1)

let timeinterval = 20.0
let nowPlus20Seconds2 = Date(timeInterval: timeinterval, since: now)
print(nowPlus20Seconds2)
//: - experiment: Find out what are other ways to create a `String`

//: ## Type Properties
//: TEXT
let wayBack = Date.distantPast
print(wayBack)

let wayForward = Date.distantFuture
print(wayForward)
//: ## Instance Methods
//: TEXT
//: ### Comparing Dates
let fifteen1 = Date(timeInterval: 15, since: now)
let fifteen2 = Date(timeInterval: 15, since: now)
let sixteen = Date(timeInterval: 16, since: now)
let seventeen = Date(timeInterval: 17, since: now)

print(fifteen1 == fifteen2)     // operator overloading using isEqual(to:)
print(sixteen < seventeen)      // operator overloading using earlierDate(_:)
print(seventeen > sixteen)      // operator overloading using laterDate(_:)

//: ### Getting Time Intervals
//: TEXT
var sinceNow = fifteen1.timeIntervalSinceNow

var twoSeconds = seventeen.timeIntervalSince(fifteen1)

//: ### Adding Time
//: TEXT
var tenSecondsAhead = fifteen1.addingTimeInterval(10)
print(tenSecondsAhead)
//: ## `Timezone`
//: Read [Timezone](https://developer.apple.com/reference/foundation/nstimezone) data type in the Swift Standard Library Reference to read more about Swift's Timezone.
let secondsFromGMT = TimeZone.current.secondsFromGMT()

print(secondsFromGMT)

let timezone = TimeZone.current.abbreviation(for: Date()) ?? ""
print(timezone)

if let timezoneName = TimeZone.current.localizedName(for: .generic, locale: nil) {
    print(timezoneName)
}
//: ## `Calendar`
//: Read [Calendar](https://developer.apple.com/reference/foundation/nscalendar) data type in the Swift Standard Library Reference to read more about Swift's Calendar.
let currentCal = Calendar.current
let calendar = Calendar(identifier: Calendar.Identifier.gregorian)

//: - experiment: Find out what the other methods are for a `Calendar`

//: ## `DateComponents`
//: Read [DateComponents](https://developer.apple.com/reference/foundation/nsdatecomponents) data type in the Swift Standard Library Reference to read more about Swift's DateComponents.
var dateComponets = DateComponents()
dateComponets.year = 2017
dateComponets.month = 1
dateComponets.day = 1

if let date2017_01_01 = calendar.date(from: dateComponets) {

    print(date2017_01_01)

    let weekday = calendar.component(.weekday, from: date2017_01_01)
}
//: ## `DateComponentsFormatter`
//: Read [DateComponentsFormatter](https://developer.apple.com/reference/foundation/datecomponentsformatter) data type in the Swift Standard Library Reference to read more about Swift's DateComponentsFormatter.
let dateComponentsFormatter = DateComponentsFormatter()
dateComponentsFormatter.unitsStyle = .full
dateComponentsFormatter.includesApproximationPhrase = true
dateComponentsFormatter.includesTimeRemainingPhrase = true
dateComponentsFormatter.allowedUnits = .second

dateComponentsFormatter.string(from: fifteen1, to: seventeen)
//: ## `DateFormatter`
//: Read [DateFormatter](https://developer.apple.com/reference/foundation/nsdateformatter) data type in the Swift Standard Library Reference to read more about Swift's DateFormatter.
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = DateFormatter.Style.medium
dateFormatter.timeStyle = DateFormatter.Style.short

let formatted1 = dateFormatter.string(from: now)

print(formatted1)

let dateFormatter2 = DateFormatter()
dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

let formatted2 = dateFormatter2.string(from: now)

print(formatted2)

if let dead = dateFormatter2.date(from: "1865-4-15T16:39:57-08:00") {
    
    print(dead)
}

/*:
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
