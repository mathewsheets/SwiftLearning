import Foundation

public func getPresidentsByCentury(century: Int) -> [String] {
    
    switch century {
    case 18:
        return ["George Washington", "John Adams"]
    case 19:
        return ["Thomas Jefferson", "James Madison", "James Monroe", "John Quincy Adams", "Andrew Jackson", "Martin Van Buren", "William Henry Harrison", "John Tyler", "James K. Polk", "Zachary Taylor", "Millard Fillmore", "Franklin Pierce", "James Buchanan", "Abraham Lincoln", "Andrew Johnson", "Ulysses S. Grant", "Rutherford B. Hayes", "James Garfield", "Chester A. Arthur", "Grover Cleveland", "Benjamin Harrison", "Grover Cleveland", "William McKinley"]
    case 20:
        return ["Theodore Roosevelt", "William Howard Taft", "Woodrow Wilson", "Warren G. Harding", "Calvin Coolidge", "Herbert Hoover", "Franklin D. Roosevelt", "Harry S. Truman", "Dwight D. Eisenhower", "John F. Kennedy", "Lyndon B. Johnson", "Richard M. Nixon", "Gerald R. Ford", "James Carter", "Ronald Reagan", "George H. W. Bush", "William J. Clinton"]
    case 21:
        return ["George Bush", "Barack Obama"]
    default:
        return []
    }
}

public func getAllPresidents() -> [String] {
    
    var presidents = [String]()
    
    presidents.appendContentsOf(getPresidentsByCentury(18))
    presidents.appendContentsOf(getPresidentsByCentury(19))
    presidents.appendContentsOf(getPresidentsByCentury(20))
    presidents.appendContentsOf(getPresidentsByCentury(21))
    
    return presidents
}
