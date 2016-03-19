import Foundation

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
