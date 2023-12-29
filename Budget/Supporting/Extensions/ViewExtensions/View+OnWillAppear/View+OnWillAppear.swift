//
//  View+OnWillAppear.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/15/23.
//

import SwiftUI

extension View {
    /// Performs the provided action when this view is about to be added to the view hierarchy
    ///
    /// - Note: This view extension utilizes a `UIViewControllerRepresentable` applied to the background of the calling view, where the `action`
    /// closure is passed into the view controller and called within its `viewWillAppear()` lifecycle method.
    ///
    /// - Parameter action: The action to perform when this view is about to be added to the view hierarchy
    func onWillAppear(perform action: @escaping () -> Void) -> some View {
        modifier(OnWillAppearModifier(perform: action))
    }
}

/// A view modifier that performs the provided action when the calling view is about to be added to the view hierarchy
private struct OnWillAppearModifier: ViewModifier {
    /// Indicates if the view calling this modifier has already appeared to prevent the `action` from being performed more than once
    @State private var hasAlreadyAppeared = false
    private let action: () -> Void
    
    init(perform action: @escaping () -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .background(
                ViewWillAppearHandler(perform: action, hasAlreadyAppeared: $hasAlreadyAppeared)
            )
            .onAppear {
                hasAlreadyAppeared = true
            }
            .onDisappear {
                hasAlreadyAppeared = false
            }
    }
}
