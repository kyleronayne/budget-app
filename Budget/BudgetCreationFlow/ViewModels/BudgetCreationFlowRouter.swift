//
//  BudgetCreationFlowRouter.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/30/24.
//

import UIKit

/// A delegate protocol that a flow router can use to communicate with its flow view.
protocol FlowRouterDelegate: AnyObject {
    func didNavigate(to step: BudgetCreationFlowStep?, inDirection direction: UIPageViewController.NavigationDirection)
}

/// A router responsible for managing the flow of steps during the budget creation process.
class BudgetCreationFlowRouter: ObservableObject {
    weak var delegate: FlowRouterDelegate?
    let firstStep: BudgetCreationFlowStep = .income
    private var currentStep: BudgetCreationFlowStep
    private var stepStack: [BudgetCreationFlowStep]
    
    init() {
        currentStep = firstStep
        stepStack = [firstStep]
    }
    
    /// Navigates the flow to the next step if available.
    func navigateForward() {
        guard let currentStep = stepStack.last else {
            return
        }
        
        var nextStep: BudgetCreationFlowStep?
        switch currentStep {
            case .income:
                nextStep = .fixedExpenses
            case .fixedExpenses:
                nextStep = .debts
            case .debts:
                nextStep = .savings
            case .savings:
                nextStep = .summary
            case .summary:
                nextStep = nil
        }
        
        // If a next step exists, add it to the stack.
        if let nextStep {
            stepStack.append(nextStep)
        }
        
        delegate?.didNavigate(to: nextStep, inDirection: .forward)
    }
    
    /// Navigates the flow to the previous step if available.
    func navigateBackward() {
        // Remove the current step from the stack if it is not empty.
        if !stepStack.isEmpty {
            stepStack.removeLast()

            let previousStep: BudgetCreationFlowStep? = stepStack.last
            delegate?.didNavigate(to: previousStep, inDirection: .reverse)
        }
    }
}
