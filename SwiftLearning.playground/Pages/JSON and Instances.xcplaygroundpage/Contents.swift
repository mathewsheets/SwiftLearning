/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # JSON & Instances
 * callout(Session Overview): Most applications are not “*solitaire*” type of applications where the application can operate in isolation and not interact with the outside world. Typical applications need to consider sending and receiving data and executing remote operations. There have been many technologies created enabling you to send data to another application or have one application execute an operation on another application. When developing mobile applications and learning the Swift programming language, the industry standard format of the data that is sent or received is a data format called **J**avascript **O**bject **N**otation, or **JSON**.
 */
import Foundation
/*:
 ## What is JSON?
 **J**avascript **O**bject **N**otation, or **JSON**, is a simple, human readable and writable data-interchange format easily parsed and created by applications. You will typically hear JSON data called a **JSON Payload**. You send and receive JSON payloads from external sources or applications.
 
 ### *Serialization* or *Marshalling*
 The process of taking data within your application and converting it into a JSON payload is called *serialization* or *marshalling*. The JSON payload can be written to a file or sent over the internet using *HTTP*. Complex data types such as enumerations, structures and classes or simple data type such as `Int`s, `String`s, `Double`s, or `Bool`s are converted to a JSON payload.

 ### *Deserialization* or *Unmarshalling*
 The process of taking a JSON payload and converting it into data used within your application is called *deserialization* or *unmarshalling*. When a JSON payload is *deserialized* or *unmarshalled*, it is converted into complex data types such as enumerations, structures and classes or simple data type such as `Int`s, `String`s, `Double`s, or `Bool`s.
 ## The Syntax
 The following is a json payload of a dictionary with key and values of `String`. **Braces** indicate a dictionary with **comma** separating key & value pairs.
 ````
 {
    "id": "52206853-2787-458d-a85b-b37c2daf73d9",
    "name": "Mathew Sheets",
    "phone": "6141234567"
 }
 ````
 The following is a json payload of an array of dictionaries with key and values of `String`. **Brackets** indicate an array with **comma** separating array elements.
 ````
 [
     {
         "id": "52206853-2787-458d-a85b-b37c2daf73d9",
         "name": "Mathew Sheets",
         "phone": "6141234567",
     },
     ...
 ]
 ````
 ### Supported data types
 The following is a json payload with data types of `Int`, `String`, `Bool`, `[Int]`, `[String:String]` and data that is nil, or in JSON **null**, meaning no value.
 ````
 {
    "number": 123456,
    "string": "value can be a string",
    "boolean": true,
    "array": [1, 2, 3],
    "dictionary": {
        "key1": "value1",
        "key2": "value2"
    },
    "isnull": null
 }
 ````
 ## The Instances or the *Object Graph*
 The data within your application, for more specifically the instances of your enumerations, structures or classes will naturally evolve into a graph of data. The graph looks like a tree, or hierarchy of data with a parent / child relation ship between the types. This tree structure of data fits nicely into a JSON payload that can be sent or received to/from an external source. The following types will be used to create a JSON payload.
 
 `PersonSummary` is a type that represents a light view of a person but provides an `id` property for us to query with to receive another type with more properties. `PersonSummary` type would be used in a list comprised of properties for display, user action or retrieval of more data.
 */
class PersonSummary {

    var id: String?     // used to retrieve the PersonDetail
    var name: String?   // used for display
    var phone: String?  // used for user to push to call
}
/*:
 Both enumerations `NamePrefix` and `NameSuffix` represent in a static type-safe way the valid options for a person's name prefix and suffix. Notice that both enumerations are of type `String` giving us the rawValue of the literal case.
 */
enum NamePrefix: String {
    case Mr
    case Ms
    case Mrs
}

enum NameSuffix: String {
    case Jr
    case Sr
}
/*:
 `Name` represents all the parts of a name. We model the name this way enabling us to format the name any way we wish.
 */
class Name {
    
    var first: String?
    var middle: String?
    var last: String?
    var prefix: NamePrefix?
    var suffix: NameSuffix?
}
/*:
 `Coordinate` represents a geo coordinate that can be leveraged on a map. It is acceptable that `Coordinate` is a structure because inheritance is not valid and we don't want `latitude` to be changed without `longitude` being reset.
 */
struct Coordinate {
    
    var latitude: Double?
    var longitude: Double?
}
/*:
 `Address` represents an address with all the parts of an address separated out into properties.
 */
class Address {

    var coordinate: Coordinate?
    var street1: String?
    var street2: String?
    var city: String?
    var county: String?
    var state: String?
    var country: String?
}
/*:
 `PersonDetail` is comprised of all the instances above to represent what a person would look like at a detail level. The `PersonDetail` type is what would be used on a detail screen displaying all the details of a person.
 */
class PersonDetail {

    var id: String?
    var name: Name?
    var phone: String?
    var company: String?
    var title: String?
    var address: Address?
    
    var description: String {
        
        var nameString = ""
        if name != nil {
            nameString += name?.prefix?.rawValue ?? ""
            nameString += " "
            nameString += name?.first ?? ""
            nameString += " "
            nameString += name?.middle ?? ""
            nameString += " "
            nameString += name?.last ?? ""
            nameString += " "
            nameString += name?.suffix?.rawValue ?? ""
        }

        var addressString = ""
        if address != nil {
            addressString += address?.street1 ?? ""
            addressString += " "
            addressString += address?.street2 ?? ""
            addressString += " "
            addressString += address?.city ?? ""
            addressString += " "
            addressString += address?.county ?? ""
            addressString += " "
            addressString += address?.state ?? ""
            addressString += " "
            addressString += address?.country ?? ""

            if let safeCoordinate = address?.coordinate {
                addressString += " ("
                addressString += String(safeCoordinate.latitude ?? 0.0)
                addressString += ", "
                addressString += String(safeCoordinate.longitude ?? 0.0)
                addressString += ")"
            }
        }

        return "\tid: \(id ?? "")\n\tname: \(nameString)\n\tphone: \(phone ?? "")\n\tcompany: \(company ?? "")\n\ttitle: \(title ?? "")\n\taddress: \(addressString ?? "")"
    }
}
/*:
 ## Enter NSJSONSerialization
 Practically all modern programing languages provide the mechanism to parse the contents of a JSON payload and/or take an object graph and create a JSON Payload. The Foundation Framework provides [NSJSONSerialization](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/index.html) for us to deserialized a JSON payload and serialize an object graph.
 
 First, we need to get the JSON payload loaded as a `String`. `summaryPayload` is a `String` that has a value of the contents from the file *persons.json* in the Resources directory. `detailPayload` is a `String` that has a value of the contents from the file *person.json*, also in the Resources directory.
 */
var summaryPayload: String?
do {
    summaryPayload = try FileUtils.getFileContents("persons.json")
} catch FileError.ReadError(let error) {
    print(error)
} catch FileError.NotFound(let path) {
    print(path)
}

if summaryPayload != nil {
    print(summaryPayload!)
}

var detailPayload: String?
do {
    detailPayload = try FileUtils.getFileContents("person.json")
} catch FileError.ReadError(let error) {
    print(error)
} catch FileError.NotFound(let path) {
    print(path)
}

if detailPayload != nil {
    print(detailPayload!)
}
/*:
 ### `NSJSONSerialization.JSONObjectWithData:options:`
 The method `NSJSONSerialization.JSONObjectWithData:options:` takes a `NSData` instance and returns an `AnyObject`. Since you know what the structure of the JSON payload will look like, you need to either type case down to an `Array` or `Dictionary`. All other types within the `Array` or `Dictionary` need to be an instance of String, Number, Array, Dictionary, or nil. `Dictionary` key must be `String`s.
 */
// start out with an array to collect all the PersonSummary instances
var personSummaries = [PersonSummary]()

// lets deal with a non optional type
if let jsonPayload = summaryPayload {

    // NSData of the JSON payload
    let jsonData = jsonPayload.dataUsingEncoding(NSUTF8StringEncoding)!
    do {
        if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) {
            
            // try to type case down
            if let personsArray = jsonObject as? [[String:AnyObject]] {
                
                // interate over the array
                for personDict in personsArray {

                    // create our PersonSummary to set values for the properties
                    var person = PersonSummary()
                    
                    // the downcasting is necessary, from above, values are AnyObject
                    person.id = personDict["id"] as? String
                    person.name = personDict["name"] as? String
                    person.phone = personDict["phone"] as? String

                    // add the person
                    personSummaries.append(person)
                }
            } else {
                print("not a array of dictionaries")
            }
        } else {
            print("could not deserialize")
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

print("-----\(personSummaries.count) PersonSummary Instances-----")
for person in personSummaries {
    
    print("\t\(person.name!)")
}

print("")

// start with an `empty instance` of PersonDetail
let personDetail = PersonDetail()

// lets deal with a non optional type
if let jsonPayload = detailPayload {
    
    // NSData of the JSON payload
    let jsonData = jsonPayload.dataUsingEncoding(NSUTF8StringEncoding)!
    do {
        if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions(rawValue: 0)) {
            
            // try to type case down
            if let personDict = jsonObject as? [String:AnyObject] {

                // try to set all the properties of personDetail

                personDetail.id = personDict["id"] as? String

                if let nameDict = personDict["name"] {

                    personDetail.name = Name()
                    
                    personDetail.name!.first = nameDict["first"] as? String
                    personDetail.name!.middle = nameDict["middle"] as? String
                    personDetail.name!.last = nameDict["last"] as? String
                    
                    if let prefix = nameDict["prefix"] as? String {
                    
                        personDetail.name!.prefix = NamePrefix(rawValue: prefix)
                    }
                    if let suffix = nameDict["suffix"] as? String {
                        
                        personDetail.name!.suffix = NameSuffix(rawValue: suffix)
                    }
                }

                personDetail.phone = personDict["phone"] as? String
                personDetail.company = personDict["company"] as? String
                personDetail.title = personDict["title"] as? String
                
                if let addressDict = personDict["address"] {
                    
                    let address = Address()
                    
                    personDetail.address = address
                    
                    if let coordinateDict = addressDict["coordinate"] as? [String:Double] {
                        
                        let latitude = coordinateDict["latitude"]
                        let longitude = coordinateDict["longitude"]

                        address.coordinate = Coordinate(latitude: latitude, longitude: longitude)
                    }

                    personDetail.address!.street1 = addressDict["street1"] as? String
                    personDetail.address!.street2 = addressDict["street2"] as? String
                    personDetail.address!.city = addressDict["city"] as? String
                    personDetail.address!.county = addressDict["county"] as? String
                    personDetail.address!.state = addressDict["state"] as? String
                    personDetail.address!.country = addressDict["country"] as? String
                }
            } else {
                print("not a dictionary")
            }
        } else {
            print("could not deserialize")
        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

print("-----Person Detail Instance-----")
print(personDetail.description)
/*:
 ### `NSJSONSerialization.dataWithJSONObject:options`
 The other half of `NSJSONSerialization` is to serialize an instance into a JSON payload. When using `NSJSONSerialization` we need to convert our instances into valid types. The rules we must follow to convert instances into a JSON payload are:
 - The top level instance is an `Array` or `Dictionary`
 - All types are instances of `String`, `Int` or `Double` (or `Float`), `Bool`, `Array`, `Dictionary`, or `nil`
 - All dictionary keys are instances of `String`
 */
//: Create an extension with a computed property to get a `Dictionary` representation of `PersonSummary`.
extension PersonSummary {

    var asDictionary: [String:AnyObject] {

        var dictionary = [String:AnyObject]()

        dictionary["id"] = id
        dictionary["name"] = name
        dictionary["phone"] = phone

        return dictionary
    }
}
/*:
 Create an extension to get an `Array` representation of `PersonSummary` instances but use type constraints to ensure that the `asDictionary` computed propety is only available on arrays where the element is of type `PersonSummary `.
 */
extension Array where Element: PersonSummary {

    var asDictionary: [[String:AnyObject]] {

        var dictionaries = [[String:AnyObject]]()

        for element in self {
            
            dictionaries.append(element.asDictionary)
        }

        return dictionaries
    }
}

print("")

do {
    print("-----JSON Payload of PersonSummary instances-----")
    
    // personSummaries.asDictionary conforms to the rules to be able to serialize the array instance of dictonary instances into a JSON payload.
    let jsonData = try NSJSONSerialization.dataWithJSONObject(personSummaries.asDictionary, options: .PrettyPrinted)
    
    // create a String from the NSData
    let jsonString = String(data: jsonData, encoding: NSUTF8StringEncoding)!
    
    print(jsonString)
    
} catch let error as NSError {
    print(error.localizedDescription)
}
/*:
 - - -
 * callout(Exercise): Using the data types in your Container from Exercise 13, create the appropriate JSON payload. Deserialize the JSON payload into instances of your data types and populate your container. Then serialize the instances back into a JSON payload.
 
 **Constraints:**
 - New methods where appropriate to deserialize and serialize the data in your container.
 
 * callout(Checkpoint): At this point, you have learned what a JSON payload is, why and when you should use it, and what is provided to you from the Foundation Framework to give you the ability to serialize instances of your data and deserialize a JSON payload.
 
 * callout(Supporting Materials): Additional Resources For Further Reading
 - [JSON Org](http://www.json.org/)
 - [JSON on Wikipedia](https://en.wikipedia.org/wiki/JSON)
 - [NSJSONSerialization](https://developer.apple.com/library/ios/documentation/Foundation/Reference/NSJSONSerialization_Class/index.html)
  - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
