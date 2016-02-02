import Foundation

public enum GradeError: ErrorType {
    case MissingLetter
    case BadLetter(youPassed: String, shouldBe: String)
    case BadNumber
}

public func createGrade(number: Int, letter: String) throws -> (Int, String)? {
    
    guard number >= 0 && number <= 100 else {
        throw GradeError.BadNumber
    }
    guard !letter.isEmpty else {
        throw GradeError.MissingLetter
    }
    
    let gradeTuple = (number, letter);
    
    switch gradeTuple {
    case (90...100, let letter) where letter != "A":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "A")
    case (80..<89, let letter) where letter != "B":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "B")
    case (70..<79, let letter) where letter != "C":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "C")
    case (60..<69, let letter) where letter != "D":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "D")
    case (0..<59, let letter) where letter != "F":
        throw GradeError.BadLetter(youPassed: letter, shouldBe: "F")
    default:
        break;
    }
    
    return gradeTuple;
}
