//
//  BudgetCreationViewModel.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/18/24.
//

import Foundation

/// A class that manages the data, user interaction, and presentation logic for a ``BudgetCreationView``
///
/// - Parameter initialStep: The step to begin the budget creation flow
class BudgetCreationViewModel: ObservableObject {
    @Published var steps: [BudgetCreationStep]
    @Published var currentStep: BudgetCreationStep
    
    init(initialStep: BudgetCreationStep = .fixedExpenses) {
        steps = [initialStep]
        currentStep = initialStep
    }
    
    /// Handles the user's tap on the next button
    func didTapNextButton() {
        var nextStep: BudgetCreationStep?
        
        switch currentStep {
            case .fixedExpenses:
                nextStep = .debts
            case .debts:
                nextStep = .savings
            case .savings:
                break
        }
        
        if let nextStep {
            removePreviousStepsIfNecessary()
            steps.append(nextStep)
            currentStep = nextStep
        }
    }
    
    /// Handles the user's tap on the back button
    func didTapBackButton() {
        if let currentStepIndex = steps.firstIndex(of: currentStep) {
            let previousStepIndex = max(0, currentStepIndex - 1)
            currentStep = steps[previousStepIndex]
        }
    }
    
    /// Removes any previous steps from the ``steps`` array.
    ///
    /// Removing a step while simultaneously transitioning to the previous step can lead to choppy or abrupt animations.
    /// By trimming the ``steps`` array to include only the steps up to and including ``currentStep``, we achieve a smooth animation between steps.
    private func removePreviousStepsIfNecessary() {
        if currentStep != steps.last {
            if let currentStepIndex = steps.firstIndex(of: currentStep) {
                steps = Array(steps.prefix(through: currentStepIndex))
            }
        }
    }
}
