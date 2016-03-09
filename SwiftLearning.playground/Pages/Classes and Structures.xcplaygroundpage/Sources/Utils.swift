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

public class DateUtils {
    
    public static func dateStringFrom(date: NSDate) -> String {
        
        let comps = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: date)
        
        return "\(comps.month)/\(comps.day)/\(comps.year)"
    }
    
    public static func createDate(year year: Int, month: Int, day: Int) -> NSDate? {
        
        guard year > 0 && month > 0 && day > 0 else {
            
            return nil
        }
        
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)
    }
    
    public static func yearSpan(from: NSDate, to: NSDate) -> Int {
        
        let calendar = NSCalendar.currentCalendar()
        
        let dateComponents: NSCalendarUnit = [.Year, .Month, .Day]
        
        let fromDateComponents = calendar.components(dateComponents, fromDate: from)
        let toDateComponents = calendar.components(dateComponents, fromDate: to)
        
        var yearSpan = toDateComponents.year - fromDateComponents.year
        
        if(fromDateComponents.month >= toDateComponents.month) {
            if(fromDateComponents.day >= toDateComponents.day) {
                ++yearSpan
            }
        }
        
        return yearSpan
    }
    
}
