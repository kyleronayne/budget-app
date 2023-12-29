//
//  View+TabBarBackgroundColor.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/13/23.
//

import SwiftUI

extension View {
    /// Applies the provided color to the background of the tab bar
    ///
    /// - Precondition:
    ///
    /// - Parameters:
    ///   - color: The background color to be applied to the tab bar
    func tabBarBackgroundColor(_ color: Color) -> some View {
        self
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(color, for: .tabBar)
    }
}
