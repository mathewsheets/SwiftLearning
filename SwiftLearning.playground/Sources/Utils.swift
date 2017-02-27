import Foundation

public class DateUtils {
    
    public static func dateString(from date: Date) -> String {
        
        let comps = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        return "\(comps.month)/\(comps.day)/\(comps.year)"
    }
    
    public static func createDate(year: Int, month: Int, day: Int) -> Date? {
        
        guard year > 0 && month > 0 && day > 0 else { return nil }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        return Calendar.current.date(from: dateComponents)
    }
    
    public static func yearSpan(from: Date, to: Date) -> Int {
        
        let calendar = Calendar.current

        let fromDateComponents = calendar.dateComponents([.year, .month, .day], from: from)
        let toDateComponents = calendar.dateComponents([.year, .month, .day], from: to)
        
        var yearSpan = toDateComponents.year! - fromDateComponents.year!
        
        if(fromDateComponents.month! >= toDateComponents.month!) {
            if(fromDateComponents.day! >= toDateComponents.day!) {
                yearSpan += 1
            }
        }
        
        return yearSpan
    }
}
