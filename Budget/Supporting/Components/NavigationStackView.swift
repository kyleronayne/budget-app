//
//  NavigationStackView.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/16/23.
//

import SwiftUI

/// A view that wraps a `NavigationStack` allowing for a styled navigation bar
/// - Parameters:
///   - barStyle: The style for the wrapped navigation stack's navigation bar
///   - path: The wrapped navigation stack's path
///   - rootView: The wrapped navigation stack's root view
struct NavigationStackView<Content: View>: View {
    @ViewBuilder private var rootView: () -> Content
    @State private var defaultPath = NavigationPath()
    private var path: Binding<NavigationPath>?
    let barStyle: NavigationBarStyle
    
    init(_ barStyle: NavigationBarStyle, path: Binding<NavigationPath>? = nil, rootView: @escaping () -> Content) {
        self.barStyle = barStyle
        self.rootView = rootView
        self.path = path
    }
    
    var body: some View {
        NavigationStack(path: path ?? $defaultPath) {
            rootView()
                .navigationBarTitleDisplayMode(barStyle.titleDisplayMode)
                .navigationDestination(for: Route.self) { route in
                    route.view
                }
        }
        .navigationBarStyle(barStyle)
    }
}
