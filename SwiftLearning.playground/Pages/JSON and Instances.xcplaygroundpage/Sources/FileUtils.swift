import Foundation

/*
 Represents the errors that could occur with getting the contents of a file
 */
public enum FileError {
    case ReadError(error: String)
    case NotFound(path: String)
}

/*:
 Make FileError conform to ErrorType, making it valid to be used in a throwing method.
 */
extension FileError: ErrorType {}

/*
 FileUtils is a class to hold all methods provided utility functions when dealing with files.
 */
public class FileUtils {

    /*
     Retrieve the contents of a file assuming the file name + extension are in the main NSBundle
     */
    public static func getFileContents(name: String, type: String) throws -> String {

        var json = ""
        
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: type) {
            do {
                json = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
            } catch let error as NSError {
                throw FileError.ReadError(error: error.localizedDescription)
            }
        } else {
            throw FileError.NotFound(path: "No file at path: \(NSBundle.mainBundle().resourcePath!)")
        }

        return json
    }

}
