//
//  BudgetCreationStep.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/18/24.
//

import SwiftUI

/// A step in the budget creation flow
enum BudgetCreationStep: CaseIterable, Hashable, Identifiable {
    case fixedExpenses
    case debts
    case savings
    
    var id: UUID {
        UUID()
    }
    
    /// The view for this step
    @ViewBuilder var view: some View {
        switch self {
            case .fixedExpenses:
                Text("Fixed Expenses")
            case .debts:
                Text("Debts")
            case .savings:
                Text("Savings")
        }
    }
}
