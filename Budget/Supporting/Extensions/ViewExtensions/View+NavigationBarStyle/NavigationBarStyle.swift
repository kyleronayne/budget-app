//
//  NavigationBarStyle.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/13/23.
//

import SwiftUI

/// A navigation bar style
enum NavigationBarStyle: Equatable {
    case `default`
    
    var backgroundColor: Color {
        switch self {
            case .default:
                return .blue
        }
    }
    
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode {
        switch self {
            case .default:
                return .inline
        }
    }
    
    var titleTextColor: Color {
        switch self {
            case .default:
                return .white
        }
    }
}
