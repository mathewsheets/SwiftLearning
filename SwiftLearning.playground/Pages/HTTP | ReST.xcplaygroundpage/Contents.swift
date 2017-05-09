/*:
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 - - -
 # HTTP & ReST
 * callout(Session Overview): Programs need to communicate to each other. They communicate by retrieving data from other programs and send data to make the other programs perform actions on its behalf. There are many communication technologies, but the industry standard is to use **H**ypertext **T**ransfer **P**rotocol along with an architectural style called **R**epresentational **S**tate **T**ransfer. HTTP with ReST allows programs implemented in different programming languages and on different operating systems the ability to communicate with each other with out the need to create a specialized technology that only two programs would know about.
 - important: This is only a brief overview of HTTP and ReST. Please take extra time outside of this session to learn all that HTTP and ReST have to offer.
 - - -
 */
import Foundation

// NEEDED TO HANDLE RESPONSES
import PlaygroundSupport
PlaygroundSupport.PlaygroundPage.current.needsIndefiniteExecution = true
/*:
 ## **H**ypertext **T**ransfer **P**rotocol or HTTP
 HTTP is an application protocol, meaning a set of rules that specifies the shared protocols and interface methods on how to send/receive and create/parse HTTP messages. There are two components to HTTP, the server and the client. The HTTP server is able to handle communicating to multiple HTTP clients simultaneously. The HTTP client, which is what we’ll focus on, will communicate with one HTTP server.
 ### The Client
 The scope of HTTP that we will focus on is the HTTP Client. The HTTP Client communicates with the HTTP server for a specific purpose by sending/receiving HTTP messages that are tailored to functionality. Think of the HTTP message as an envelope that has to/from addresses with a letter representing the data. We will refer to sending and receiving HTTP messages as request and response.
 
 This is a simple HTTP Request message
 ````
 GET /person/ HTTP/1.1
 Host: www.people.com
 Accept: text/json
 ````
 This is a simple HTTP Response message
 ````
 HTTP/1.1 200 OK
 Content-Length: 44
 Connection: close
 Content-Type: text/json
 {
 
 }
 ````
 ## **R**epresentational **S**tate **T**ransfer or ReST
 ReST is not a standard, but more of an easily understandable agreement between the HTTP Client and HTTP Server on how and what should be sent and received as well as how the data should be handled. The industry standard data format that ReSTful Clients and Servers use is the JSON data format. With ReST, you want to narrow your scope of functionality and data to a concept called a Resource. A Person is a resource. The client needs a list of persons, the server knows how to retrieve a list of persons and responds with a JSON payload that the client knows how to handle. There are four main components to ReST: the HTTP Method, the URI, the data or payload, and the response code.
 
 ## Methods or Verbs
 The HTTP Method, or HTTP verb, is used by the client in the request to tell the server what should happen. A client typically needs to **C**reate, **R**etrieve, **U**pdate or **D**elete data.
 - `POST` = Tells the server to **create** data
 - `GET` = Tells the server to **retrieve** data
 - `PUT` = Tells the server to **update** data
 - `DELETE` = Tells the server to **delete** data
 
 ## URI
 The **U**niform **R**esource **I**dentifier or URI is used to identify the resource. Think of the URI as the path portion of a URL. Below is the URI for the person resource.
 
 `/persons`
 
 ## Data
 The data that is requested by the client or responded to by the server will be in the JSON data format but structured in a way that makes sense for the resource.
 
 Client requests to create a Person:
 ````
 {
     "name": "Mathew Sheets",
     "phone": "6141234567",
 }
 ````
 Server responds with a list of Persons:
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
 ## Response Codes
 Along with a JSON payload, a server responds with a status code that can be interpreted by the client for the client to make a decision. Below are the most commonly used status codes when dealing with ReSTful services.
 
 - `2xx` Success
 - `200 OK` = The request was successfully handled by the server and will typically have a JSON payload in the response.
 - `201 Created` = The request was successfully handled by the server and a resource was created with a JSON payload of a URI of the new resource.
 - `204 No Content` = The request was successfully handled by the server but no JSON payload in the response.
 - `3xx` Redirection
 - `301 Moved Permanently` = The resource has been moved.
 - `304 Not Modified` = The resource has not changed.
 - `4xx` Client Error
 - `400 Bad Request` = The request is invalid for a resource.
 - `401 Unauthorized` = The request is unauthorized for a resource.
 - `403 Forbidden` = The request is not allowed for a resource
 - `404 Not Found` = The resource can not be found.
 - `5xx` Server Error
 - `501 Internal Server Error` = A generic error from the server.
 - `500 Not Implemented` = An error from the server indicating to the client that the request has not been implemented.
 
 ## Person Resource and Routes
 Consider that we want to communicate with a server that will produce a ReSTful service for a Person resource. Our program is the client what will consume the ReSTful service. The following is a brief example of what the HTTP method, URI, data and response code would look like. The HTTP method, URI, data and response code is considered a *route* for the resource and there are typically 5 routes per resource.
 
 ### `GET /persons`
 Above is a *route* of a `GET` request for the *person* resource. Below is the response JSON payload of an array with each element in the array representing a person. This URI indicates all persons; here the absence of an `id`
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
 ### `GET /persons/52206853-2787-458d-a85b-b37c2daf73d9`
 Above is a *route* of a `GET` request for a single *person* resource. Notice the `id:`, indicating the `id` of a specific person.
 ````
 {
     "id": "52206853-2787-458d-a85b-b37c2daf73d9",
     "name": "Mathew Sheets",
     "phone": "6141234567",
 }
 ````
 ### `POST /persons`
 Above is a *route* of a `POST` request to create a *person* resource. Below is the request JSON payload.
 ````
 {
     "name": "Mathew Sheets",
     "phone": "6141234567",
 }
 ````
 ### `PUT /persons/52206853-2787-458d-a85b-b37c2daf73d9`
 Above is a *route* of a `PUT` request to update a *person* resource. Notice the `id:`, indicating the `id` of a specific person. Below is the request JSON payload.
 ````
 {
     "name": "Matt Sheets",
     "phone": "6141234567",
 }
 ````
 ### `DELETE /persons/52206853-2787-458d-a85b-b37c2daf73d9`
 Above is a *route* of a `DELETE` request to delete a *person* resource. Notice the `id:`, indicating the `id` of a specific person.
 */
/*:
 ## URLRequest, URLResponse and URLSession
 The Foundation Framework provides an API to interact with HTTP and ReSTful services. The three main classes involved in executing HTTP requests and handling responses are `URLRequest`, `URLResponse` and `URLSession`.
 - [URLRequest](https://developer.apple.com/reference/foundation/nsurlrequest) = The class representing the request portion of the HTTP protocol
 - [URLResponse](https://developer.apple.com/reference/foundation/urlresponse) = The class representing the response portion of the HTTP protocol
 - [URLSession](https://developer.apple.com/reference/foundation/urlsession) = The class managing the collaboration between the request and response and also providing other capabilities such as caching
 */
var host = "http://cscc-persons.getsandbox.com"
var session = URLSession.shared
/*:
 ### `GET /persons`
 - example: Below is an example implementation of the `GET /persons` route on the Person resource. This will get an array of person resources.
 */
var request = URLRequest(url: URL(string: "\(host)/persons")!)
request.httpMethod = "GET"
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
session.dataTask(with: request) { (data, response, error) in
    
    if error != nil {
        print(error!)
    } else {
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        guard statusCode! >= 200 && statusCode! < 300, let json = data else {
            return
        }

        var result = String(data: json, encoding: .utf8)!
        
        print(result)
    }
}.resume()
/*:
 - experiment: Uncomment above and see what happends
 */
/*:
 ### `GET /persons/id:`
 - example: Below is an example implementation of the `GET /persons/id:` route on the Person resource. This will get a single person resource.
 */
//var request = URLRequest(url: URL(string: "\(host)/persons/ea0163c0-3db4-4a6f-8890-ed3e4827d402")!)
//request.httpMethod = "GET"
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//session.dataTask(with: request) { (data, response, error) in
//    
//    if error != nil {
//        print(error!)
//    } else {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//        guard statusCode! >= 200 && statusCode! < 300, let json = data else {
//            return
//        }
//        
//        var result = String(data: json, encoding: String.Encoding.utf8)!
//        
//        print(result)
//    }
//}.resume()
/*:
 - experiment: Uncomment above and see what happends
 */
/*:
 ### `POST /persons`
 - example: Below is an example implementation of the `POST /persons` route on the Person resource. This will create a person resource.
 */
//let jsonPayload = "{\"first\":\"Mathew\", \"last\":\"Sheets\", \"phone\":\"16141234567\"}"
//
//var request = URLRequest(url: URL(string: "\(host)/persons")!)
//request.httpMethod = "POST"
//request.httpBody = jsonPayload.data(using: .utf8)
//
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//session.dataTask(with: request) { (data, response, error) in
//
//    if error != nil {
//        print(error!)
//    } else {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//        guard statusCode! >= 200 && statusCode! < 300, let json = data else {
//            return
//        }
//
//        var result = String(data: json, encoding: String.Encoding.utf8)!
//
//        print(result)
//    }
//}.resume()
/*:
 - experiment: Uncomment above and see what happends
 */
/*:
 ### `PUT /persons/id:`
 - example: Below is an example implementation of the `PUT /persons/id:` route on the Person resource. This will update a person resource.
 */
//let jsonPayload = "{\"first\":\"Matt\", \"phone\":\"16147654321\"}"
//
//var request = URLRequest(url: URL(string: "\(host)/persons/ea0163c0-3db4-4a6f-8890-ed3e4827d402")!)
//request.httpMethod = "PUT"
//request.httpBody = jsonPayload.data(using: .utf8)
//
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//session.dataTask(with: request) { (data, response, error) in
//
//    if error != nil {
//        print(error!)
//    } else {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//        guard statusCode! >= 200 && statusCode! < 300 else {
//            return
//        }
//
//        print("good response")
//    }
//}.resume()
/*:
 - experiment: Uncomment above and see what happends
 */
/*:
 ### `DELETE /persons/id:`
 - example: Below is an example implementation of the `DELETE /persons/id:` route on the Person resource. This will delete a person resource.
 */
//var request = URLRequest(url: URL(string: "\(host)/persons/ea0163c0-3db4-4a6f-8890-ed3e4827d402")!)
//request.httpMethod = "DELETE"
//
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//session.dataTask(with: request) { (data, response, error) in
//    
//    if error != nil {
//        print(error!)
//    } else {
//        let statusCode = (response as? HTTPURLResponse)?.statusCode
//        guard statusCode! >= 200 && statusCode! < 300 else {
//            return
//        }
//        
//        print("good response")
//    }
//}.resume()
/*:
 - experiment: Uncomment above and see what happends
 */
/*:
 - - -
 * callout(Exercise): Create a Person API by creating a protocol and two classes conforming to the protocol with methods to create, retrieve, update and delete persons. One of the classes should *mock* the HTTP Client for the `GET` routes reading files for the JSON payload. The other class should leverage the above examples.
 
 **Constraints:**
 - Protocol with methods to create, retrieve, update and delete person instances
 - Class conforming to the protocol reading files for the JSON payloads
 - Class conforming to the protocol using URLRequest, URLResponse and URLSession
 - Each method body must use the appropriate example when implementing the HTTP Client class
 - Each method body must use what you learned in [JSON & Instances](JSON%20and%20Instances) to serialize/deserialize a person instances
 
 * callout(Checkpoint): At this point, you should have basic knowledge of HTTP and ReSt outside the context of an operating system and programming language. We learned the five main routes for a ReSTful resource and the HTTP method, URI, data, and possible response codes for each. We also learned about the three main components that is provided from the Foundation Framework available in Swift programs enabling using to communicate with another program.
 
 * callout(Supporting Materials): Additional Resources For Further Reading
 - [URL Loading System](https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/URLLoadingSystem/URLLoadingSystem.html#//apple_ref/doc/uid/10000165i)
 - [ReST on Wikipedia](https://en.wikipedia.org/wiki/Representational_state_transfer)
 - [ReST API Tutorial](http://www.restapitutorial.com/)
 - [Response Status Codes](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)
 - [cURL as a HTTP Client](https://curl.haxx.se/docs/manpage.html)
 - [ReSTful Service Sandboxing](https://getsandbox.com)
 - - -
 [Table of Contents](@first) | [Previous](@previous) | [Next](@next)
 */
