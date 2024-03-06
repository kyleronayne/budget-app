//
//  BudgetCreationFlow2.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/29/24.
//

import SwiftUI

/// A view that guides the user through a series of steps to create a new budget.
struct BudgetCreationFlowView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return BudgetCreationFlowViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No-op
    }
}

/// A view controller that guides the user through a series of steps to create a new budget.
private class BudgetCreationFlowViewController: UIViewController, FlowRouterDelegate {
    @ObservedObject private var flowRouter = BudgetCreationFlowRouter()
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flowRouter.delegate = self
        configureView()
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .plain()
        button.configuration?.baseForegroundColor = .black
        button.configuration?.image = UIImage(systemName: "chevron.backward")
        button.configuration?.imagePadding = 10
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    /// Configures this view with a back button and a `UIPageViewController`.
    private func configureView() {
        view.addSubview(backButton)
        
        guard let pageView = pageViewController.view else {
            return
        }
        
        view.addSubview(pageView)
        
        pageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set the current step to the flow router's first step.
        pageViewController.setViewControllers([self.makeViewController(forStep: flowRouter.firstStep)], direction: .forward, animated: false)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pageView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            pageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    /// Creates a view controller for a specified flow step.
    ///
    /// - Note: The view controller returned is provided a ``BudgetCreationFlowRouter`` as an environment object.
    ///
    /// - Parameter step: The step for which to create a view controller.
    ///
    /// - Returns: A view controller.
    private func makeViewController(forStep step: BudgetCreationFlowStep) -> UIViewController {
        let stepView: some View = step.view.environmentObject(flowRouter)
        return UIHostingController(rootView: stepView)
    }
    
    /// Handles the user's tap on the back button.
    @objc private func didTapBackButton() {
        flowRouter.navigateBackward()
    }
    
    // MARK: - FlowRouterDelegate Methods
    
    /// Updates the flow to display the specified step or dismisses it if the step is `nil`.
    ///
    /// - Parameters:
    ///   - step: The step for which to navigate. `nil` if the flow has ended.
    ///   - direction: The direction in which the flow should navigate.
    func didNavigate(to step: BudgetCreationFlowStep?, inDirection direction: UIPageViewController.NavigationDirection) {
        // If the received step is not nil, set it as the current step; otherwise, dismiss the flow.
        if let step {
            backButton.isEnabled = false
            
            pageViewController.setViewControllers([makeViewController(forStep: step)], direction: direction, animated: true) { didFinishNavigating in
                if didFinishNavigating {
                    self.backButton.isEnabled = true
                }
            }
        } else {
            dismiss(animated: true)
        }
    }
}
