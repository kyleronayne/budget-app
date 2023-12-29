//
//  Route.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/20/23.
//

import SwiftUI

/// Represents a view that can be programmatically navigated to using the ``NavigationRouter``
enum Route: Hashable {
    case budget
    
    /// Returns `true` if this route represents the root view of a tab
    var isTabRoot: Bool {
        switch self {
            case .budget:
                return true
        }
    }
    
    /// The parent tab of this route
    var parentTab: Tab {
        switch self {
            case .budget:
                return .budget
        
        }
    }
    
    /// The path required to navigate to this route from its parent tab
    var path: [Route] {
        var path: [Route] = []
        
        // Only set the path array to the routes that precede this route within the parent tab's navigation hierarchy
        switch self {
            default:
                break
        }
        
        return path + [self]
    }
    
    /// The view that this route represents
    @ViewBuilder var view: some View {
        switch self {
            case .budget:
                Text("Hello, world!")
        }
    }
}
