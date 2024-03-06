//
//  BudgetCreationFlowStep.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/18/24.
//

import SwiftUI

/// A step in the budget creation flow.
enum BudgetCreationFlowStep: CaseIterable, Hashable, Identifiable {
    case income
    case fixedExpenses
    case debts
    case savings
    case summary
    
    var id: UUID {
        UUID()
    }
    
    /// The view for this step.
    @ViewBuilder var view: some View {
        switch self {
            case .income:
                Text("IncomeEntryView")
            case .fixedExpenses:
                Text("FixedExpensesEntryView")
            case .debts:
                Text("DebtsEntryView")
            case .savings:
                Text("SavingsEntryView")
            case .summary:
                Text("BudgetCreationSummaryView")
        }
    }
}
