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
                return .white
        }
    }
    
    var titleDisplayMode: NavigationBarItem.TitleDisplayMode {
        switch self {
            case .default:
                return .large
        }
    }
    
    var titleTextColor: Color {
        switch self {
            case .default:
                return .black
        }
    }
}
