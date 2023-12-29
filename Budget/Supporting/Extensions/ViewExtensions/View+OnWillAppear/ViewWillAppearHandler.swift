//
//  ViewWillAppearHandler.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/15/23.
//

import SwiftUI

/// A `UIViewControllerRepresentable` that allows SwiftUI views to utilize the `viewWillAppear()` UIKit lifecycle method
///
/// - Parameters:
///   - action: The action to perform when this view controller is about to be added to the view hierarchy
///   - hasAlreadyAppeared: Indicates if the SwiftUI view using this handler has already appeared to prevent the `action` from being performed more than once
struct ViewWillAppearHandler: UIViewControllerRepresentable {
    @Binding private var hasAlreadyAppeared: Bool
    private let action: () -> Void
    
    init(perform action: @escaping () -> Void, hasAlreadyAppeared: Binding<Bool>) {
        self.action = action
        self._hasAlreadyAppeared = hasAlreadyAppeared
    }

    func makeUIViewController(context: Context) -> UIViewController {
        UILifecycleEventViewController(perform: action, hasAlreadyAppeared: $hasAlreadyAppeared)
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No-op
    }
    
    /// A `UIViewController` that calls an action closure in its `viewWillAppear()` lifecycle method
    ///
    /// - Parameters:
    ///   - action: The action to perform when this view controller is about to be added to the view hierarchy
    ///   - hasAlreadyAppeared: Indicates if the SwiftUI view using this handler has already appeared to prevent the `action` from being performed more than once
    final private class UILifecycleEventViewController: UIViewController {
        @Binding var hasAlreadyAppeared: Bool
        private let action: () -> Void
        
        init(perform action: @escaping () -> Void, hasAlreadyAppeared: Binding<Bool>) {
            self.action = action
            self._hasAlreadyAppeared = hasAlreadyAppeared
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if !hasAlreadyAppeared {
                action()
            }
        }
    }
}
