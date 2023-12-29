//
//  View+NavigationBarStyle.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/14/23.
//

import SwiftUI

extension View {
    /// Applies the provided style to the navigation bar of this view's navigation stack
    ///
    /// - Precondition: This extension will only take effect when it is applied directly to a `NavigationStack` or one of its child views.
    ///
    /// - Parameter style: The style for the navigation bar
    ///
    /// - Returns: A view with a styled navigation bar
    func navigationBarStyle(_ style: NavigationBarStyle) -> some View {
        self
            .onWillAppear {
                applyStyle(style)
            }
    }
    
    /// Applies the provided style to the navigation bar of this view's navigation stack
    /// 
    /// - Parameter style: The style for the navigation bar
    private func applyStyle(_ style: NavigationBarStyle) {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(style.backgroundColor)
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(style.titleTextColor)]
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(style.titleTextColor)]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}
