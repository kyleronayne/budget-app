//
//  BudgetTabViewModel.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/29/23.
//

import Foundation

/// A class that manages the data, user interaction, and presentation logic for a ``BudgetTabView``
class BudgetTabViewModel: ObservableObject {
    @Published var selectedBudgetMonth: DateComponents
    @Published var isShowingBudgetCreationView = false
    
    init() {
        selectedBudgetMonth = Calendar.current.dateComponents([.year, .month], from: Date())
    }
    
    static private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"

        return dateFormatter
    }()
    
    var selectedBudgetMonthString: (month: String, year: String) {
        let monthString = makeMonthString(from: selectedBudgetMonth)
        let monthStringWords: [String] = monthString.components(separatedBy: " ")
        
        if monthStringWords.count == 2 {
            return (monthStringWords[0], monthStringWords[1])
        } else {
            return ("", "")
        }
    }
    
    var availableBudgetMonths: [DateComponents] {
        var months: [DateComponents] = []
        let today = Date()
        
        // Create months +/- 1 year from today
        for monthIndex in -12...12 {
            if let month = Calendar.current.date(byAdding: .month, value: monthIndex, to: today) {
                let monthDateComponents = Calendar.current.dateComponents([.year, .month], from: month)
                months.append(monthDateComponents)
            }
        }

        return months
    }
    
    /// Creates a string for the month represented by the provided date components
    ///
    /// - Parameter month: Date components containing year and month properties
    ///
    /// - Returns: A month string
    func makeMonthString(from month: DateComponents) -> String {
        guard let dateForMonth = Calendar.current.date(from: month) else {
            return ""
        }
        
        return BudgetTabViewModel.dateFormatter.string(from: dateForMonth)
    }
}
