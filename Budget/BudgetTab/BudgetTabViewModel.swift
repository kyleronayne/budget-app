//
//  BudgetTabViewModel.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/29/23.
//

import Foundation

/// The class that manages a ``BudgetTabView``
class BudgetTabViewModel: ObservableObject {
    @Published var selectedBudgetMonth: DateComponents = {
        Calendar.current.dateComponents([.year, .month], from: Date())
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"

        return dateFormatter
    }()
    
    var budgetMonths: [DateComponents] {
        var months: [DateComponents] = []
        let today = Date()
        
        // Generate months +/- 1 year from today
        for monthIndex in -12...12 {
            if let month = Calendar.current.date(byAdding: .month, value: monthIndex, to: today) {
                let monthDateComponents = Calendar.current.dateComponents([.year, .month], from: month)
                months.append(monthDateComponents)
            }
        }

        return months
    }
    
    /// Creates an attributed month string from the provided date components
    ///
    /// - Parameter month: Date components containing year and month properties
    ///
    /// - Returns: An attributed month string
    func makeAttributedMonthString(from month: DateComponents) -> AttributedString {
        guard let dateForMonth = Calendar.current.date(from: month) else {
            return ""
        }
        
        let rawMonthString = BudgetTabViewModel.dateFormatter.string(from: dateForMonth)
        let rawMonthStringWords: [String] = rawMonthString.components(separatedBy: " ")
        var attributedMonthString = AttributedString(rawMonthString)

        guard let monthStringRange = attributedMonthString.range(of: rawMonthStringWords[0]) else {
            return ""
        }
        
        guard let yearStringRange = attributedMonthString.range(of: rawMonthStringWords[1]) else {
            return ""
        }
        
        attributedMonthString[monthStringRange].font = .title2.bold()
        attributedMonthString[yearStringRange].font = .caption
        
        return attributedMonthString
    }
}
