//
//  NavigationRouter.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/15/23.
//

import SwiftUI

/// A class that facilitates global user navigation
///
/// - Note: The router can be accessed within all views via an environment object.
class NavigationRouter: ObservableObject {
    @Published var activeTab: Tab = .budget
    @Published private var budgetNavigationPath = NavigationPath()
    
    /// Returns the navigation path for the provided tab
    ///
    /// - Parameter tab: The tab for which to receive a navigation path
    ///
    /// - Returns: A navigation path
    func navigationPath(forTab tab: Tab) -> Binding<NavigationPath> {
        switch tab {
            case .budget:
                return Binding(
                    get: { self.budgetNavigationPath },
                    set: { self.budgetNavigationPath = $0 }
                )
        }
    }
    
    /// Navigates the user to the provided route
    ///
    /// - Note: If the provided route represents the root view of a tab, the router will only switch to that tab.
    ///
    /// - Parameter route: The route in which to navigate
    func route(to route: Route) {
        activeTab = route.parentTab
        
        if !route.isTabRoot {
            switch route.parentTab {
                case .budget:
                    budgetNavigationPath = NavigationPath(route.path)
            }
        }
    }
    
    /// Returns the user to the root view of the active tab
    func popToRoot() {
        switch activeTab {
            case .budget:
                budgetNavigationPath.removeLast(budgetNavigationPath.count)
        }
    }
}
