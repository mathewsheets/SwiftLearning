/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # Strings & Characters & Dates
 * callout(Session Overview): Strings are one of Swift's fundamental data types that stores a series of characters such as "Hello Student". In this session we will go into more detail about `String`'s capabilities and learn what properties and methods that are available. Please refer to the Swift Language Guide section [Strings and Characters](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285) and also the [String](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_String_Structure/index.html#//apple_ref/swift/struct/s:SS) and [Character](https://developer.apple.com/reference/swift/character) data types in the Swift Standard Library Reference to read more about Swift's strings and characters.
 
    Swift and the Foundation framework provides the ability to create dates, structured series of numbers and characters that represent a date and time. With a `Date` you can perform date arithmetic and represent point in time within your program. Visit [The Date Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/DatesAndTimes/DatesAndTimes.html#//apple_ref/doc/uid/10000039i) to read about working with dates.
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
//: ## Instance Properties
//: All Strings have attributes called properties that provide you the ability to retrieve information about an instance of a String.
//:
// Use `isEmpty` to determine if a String has a value.
print("The string is empty? = \(abeQuote.isEmpty)")

let anotherQuote = ""

print("The string is empty? = \(anotherQuote.isEmpty)")

// The `characters` property provides access to the collection of characters in a String. Use the `characters.count` to get the count of number of characters in a String.
print("Quote has \(abeQuote.characters.count) characters")

// Use `startIndex` to get the index of the starting position of a String.
let startIndex = abeQuote.startIndex
print("The start index is \(startIndex)")

// Use `endIndex` to get the index of the ending position of a String.
let endIndex = abeQuote.endIndex
print("The endIndex index is \(endIndex)")
//: ## Instance Methods
//: All Strings have methods that allow you to interact with a String, such as adding to, removing from, replacing within, checking for the existence of other characters of Strings, and finding substrings from based on indexes or ranges.
// Use `lowercased()` to convert all characters in the String to lowercase.
print(abeQuote.lowercased())

// Use `uppercased()` to convert all characters in the String to uppercase.
print(abeQuote.uppercased())
//: ### Findng `Character`s
//: Swift's `String` provides the ability to get a `Character` by using indexes and subscripts.
abeQuote[abeQuote.index(after: startIndex)]         // Get the character after the startIndex
abeQuote[abeQuote.index(before: endIndex)]          // Get the character before the endIndex
abeQuote[abeQuote.index(startIndex, offsetBy: 1)]   // Get the character using the startIndex as a starting point with an offset of 1
abeQuote[abeQuote.index(endIndex, offsetBy: -4)]    // Get the character using the endIndex as a starting point with an offset of -4

// Get the character using the startIndex as a starting point with an offset of 3 but don't go past the endIndex
if let index = abeQuote.index(startIndex, offsetBy: 3, limitedBy: endIndex) {
    abeQuote[index] // "e"
}

// Find the index of a given String
let matchedIndex = abeQuote.characters.index(of: "s")
let nomatchIndex = abeQuote.characters.index(of: "Z")

// Find the distance between two indexes
let distance = abeQuote.distance(from: abeQuote.startIndex, to: abeQuote.index(endIndex, offsetBy: -6))
//: ### Ranges
//: We can use ranges with strings to query for other strings.
let url = "www.cscc.edu";
let urlEndIndex = url.endIndex
let tldStartIndex = url.index(urlEndIndex, offsetBy: -3)

// Use a range to get the top level domain
let tldRange = Range(uncheckedBounds: (lower: tldStartIndex, upper: urlEndIndex))
print(url[tldRange])

// Get the url without the top level domain
let endOfDomain = url.index(url.endIndex, offsetBy: -4)
let rangeOfDomain = url.startIndex ..< endOfDomain
print(url[rangeOfDomain])

// get a range from a string
if let rangeOfTLD = url.range(of: "edu") {
    print(url[rangeOfTLD])
}
/*:
 ### Adding to a String
 You can create a new String by concatenating multiple strings together or change the contents within a String by using either append or insert.
 */
let quoteFirstHalf = "Give me six hours to chop down a tree"
let quoteSecondHalf = "and I will spend the first four sharpening the axe"

// Use `+` the plus symbol to add or concat multiple string together
let quoteFull = quoteFirstHalf + " " + quoteSecondHalf

var quoteFull2 = quoteFirstHalf
quoteFull2 += " " + quoteSecondHalf // also allowd to use the compound assignment add operator

print(quoteFull == quoteFull2)

// Use `append` to add a `Character` to the end of a string.
var give = "G"
var charI: Character = "i"
var charV: Character = "v"
var charE: Character = "e"
give.append(charI)
give.append(charV)
give.append(charE)

// Use `insert` to add a character at the specified index.
give.insert("!", at: give.endIndex)

// Use `insert(contentsOf:)` to add the characters of a String at the specified index.
give.insert(contentsOf: " me six hours".characters, at: give.index(give.startIndex, offsetBy: 5))
//: ### Removing from a String
//: You can also remove characters or a range of characters within a String.
// Use `removeAll` to remove all characters from a String
abeQuote2.removeAll();

print(abeQuote2)

abeQuote2 += "Better to remain silent and be thought a fool than to speak out and remove all doubt."

// Use `remove(at:)` to remove a character at the specified index.
abeQuote2.remove(at: abeQuote2.index(before: abeQuote2.endIndex))

print(abeQuote2)

// Use `removeRange` to remove characters using the specified range.
let range = abeQuote2.index(abeQuote2.endIndex, offsetBy: -6)..<abeQuote2.endIndex

abeQuote2.removeSubrange(range)
//: ### Replacing content in a String
//: You can replace a portion of a String with another Character or String.
let range2 = abeQuote2.index(abeQuote2.endIndex, offsetBy: -39)..<abeQuote2.index(abeQuote2.endIndex, offsetBy: -38)

// Use `replaceSubrange(: with:)` to replace the range with the given string
abeQuote2.replaceSubrange(range2, with: "A")
//: - experiment: Find out what other replace methods exist for a String.

//: ### Checking for values
//: You can check if a String starts with (Prefix) or ends with (Suffix) a String.
// Use `hasPrefix(_:)` to see if a string starts with the given string
let startsWith = abeQuote2.hasPrefix("Better");

// use `hasSuffix(_:)`
let endsWith = abeQuote2.hasSuffix("doubt!")
//: ### Finding Substrings
//: You can find Strings contained in other Strings, also known as substrings.
// Use `substring(from:)` to get a substring starting with an index
let giveHimPower = abeQuote3.substring(from: abeQuote3.index(abeQuote3.endIndex, offsetBy: -15))

// Use `substring(to:)` to get a substring up to the index
let adversity = abeQuote3.substring(to: abeQuote3.index(abeQuote3.startIndex, offsetBy: 34))

// Use `substring(with:)` to get a substring based off of a range
let test = abeQuote3.substring(with: abeQuote3.index(abeQuote3.startIndex, offsetBy: 55)..<abeQuote3.index(abeQuote3.endIndex, offsetBy: -17))
//: - - -
//: - - -
//: # `Date`s
//: A date is a single point in time. Read [Date](https://developer.apple.com/reference/foundation/nsdate) data type in the Swift Standard Library Reference to read more about Swift's Dates.
//: ## Creating
// Create a date representing *now*
let now = Date();
print(now)

// Create a date 20 seconds from now
let nowPlus20Seconds1 = Date(timeIntervalSinceNow: 20)
print(nowPlus20Seconds1)

// Create another date 20 seconds from now
let timeinterval = 20.0
let nowPlus20Seconds2 = Date(timeInterval: timeinterval, since: now)
print(nowPlus20Seconds2)
//: - experiment: Find out what are other ways to create a `String`

//: ## Properties
// Date has a type property to represent the beginning of time.
let wayBack = Date.distantPast
print(wayBack)

// Date has a type property to represent the future
let wayForward = Date.distantFuture
print(wayForward)

// Date has a instance property to get the time interval from now
var sinceNow = nowPlus20Seconds2.timeIntervalSinceNow
//: ### Comparing Dates
//: With a Swift `Date`, you can perform comparison operators between two dates.
let fifteen1 = Date(timeInterval: 15, since: now)   // date 15 seconds from now
let fifteen2 = Date(timeInterval: 15, since: now)   // another date 15 seconds from now
let sixteen = Date(timeInterval: 16, since: now)    // date 16 seconds from now
let seventeen = Date(timeInterval: 17, since: now)  // date 17 seconds from now

print(fifteen1 == fifteen2)     // operator overloading using isEqual(to:)
print(sixteen < seventeen)      // operator overloading using earlierDate(_:)
print(seventeen > sixteen)      // operator overloading using laterDate(_:)
//: ## Instance Methods
//: ### Getting Time Intervals
//: Get the time interval between two dates.
// Here the time interval between fifteen1 and seventeen is 2 seconds
var twoSeconds = seventeen.timeIntervalSince(fifteen1)
//: ### Adding Time
//: We can add a time interval to create a new date
// Add 10 seconds to fifteen1
var tenSecondsAhead = fifteen1.addingTimeInterval(10)
print(tenSecondsAhead)
//: ## `Timezone`
//: Swit provides `Timezone` to represent regions that have different time. Read the [Timezone](https://developer.apple.com/reference/foundation/nstimezone) data type in the Swift Standard Library Reference to read more about Swift's Timezone.
// Get the seconds from GMT and do some conversions
let secondsFromGMT = TimeZone.current.secondsFromGMT()
let minutesFromGMT = secondsFromGMT / 60
let hoursFromGMT = minutesFromGMT / 60

// Get the string representing the timezone
let timezone = TimeZone.current.abbreviation(for: Date()) ?? ""

// Get a localized string representing the timezone
if let timezoneName = TimeZone.current.localizedName(for: .generic, locale: nil) {
    print(timezoneName)
}
//: ## `Calendar`
//: The `Calendar` is used to represent different calendars. Read the [Calendar](https://developer.apple.com/reference/foundation/nscalendar) data type in the Swift Standard Library Reference to read more about Swift's Calendar.
// Get the current calendar from my system
let currentCal = Calendar.current

// Get the gregorian calendar
let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//: - experiment: Find out what the other methods are for a `Calendar`

//: ## `DateComponents`
//: The `DateComponents` is used to set the individual components for a date. Read the [DateComponents](https://developer.apple.com/reference/foundation/nsdatecomponents) data type in the Swift Standard Library Reference to read more about Swift's DateComponents.
// Use DateComponents to create a new date
var dateComponets = DateComponents()
dateComponets.year = 2017
dateComponets.month = 1
dateComponets.day = 1

// From a calendar instance, create the new date. We use optional binding to test if we actually created a date.
if let date2017_01_01 = calendar.date(from: dateComponets) {

    print(date2017_01_01)

    // You can get a component of a date
    let weekday = calendar.component(.weekday, from: date2017_01_01)
}
//: ## `DateComponentsFormatter`
//: The `DateComponentsFormatter` is used to create a string with predetermined phrases. Read the [DateComponentsFormatter](https://developer.apple.com/reference/foundation/datecomponentsformatter) data type in the Swift Standard Library Reference to read more about Swift's DateComponentsFormatter.
// Create a date component formatter that has the approximation and time remaining phrase for on the second unit
let dateComponentsFormatter = DateComponentsFormatter()
dateComponentsFormatter.unitsStyle = .full
dateComponentsFormatter.includesApproximationPhrase = true
dateComponentsFormatter.includesTimeRemainingPhrase = true
dateComponentsFormatter.allowedUnits = .second

// Get a string displaying how many seconds to dates are apart
dateComponentsFormatter.string(from: fifteen1, to: seventeen)
//: ## `DateFormatter`
//: The `DateFormatter` is used to format dates into string. Read the [DateFormatter](https://developer.apple.com/reference/foundation/nsdateformatter) data type in the Swift Standard Library Reference to read more about Swift's DateFormatter. [Date Formats](http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns)
// Create a date formatter that has a date style of medium and a time style of short
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = DateFormatter.Style.medium
dateFormatter.timeStyle = DateFormatter.Style.short

// Use the date formatter `string(from:)` method to format the date into a string
let formatted1 = dateFormatter.string(from: now)

// Set the property `dateFormat` on the date formatter to a specified format
let dateFormatter2 = DateFormatter()
dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

// Get the new formatted string
let formatted2 = dateFormatter2.string(from: now)

// Use the `date(from:)` method to create a date from a formatted date string
if let dead = dateFormatter2.date(from: "1865-04-15T16:39:57-05:00") {
    
    print(dead)
}
/*:
 - - -
 * callout(Supporting Materials): References from Swift's Standard Library and Foundation Framework
 - [String](https://developer.apple.com/library/prerelease/mac/documentation/Swift/Reference/Swift_String_Structure/index.html#//apple_ref/swift/struct/s:SS)
 - [Character](https://developer.apple.com/reference/swift/character)
 - [Date](https://developer.apple.com/reference/foundation/nsdate)
 - [Timezone](https://developer.apple.com/reference/foundation/nstimezone)
 - [Calendar](https://developer.apple.com/reference/foundation/nscalendar)
 - [DateComponents](https://developer.apple.com/reference/foundation/nsdatecomponents)
 - [DateComponentsFormatter](https://developer.apple.com/reference/foundation/datecomponentsformatter)
 - [DateFormatter](https://developer.apple.com/reference/foundation/nsdateformatter)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
