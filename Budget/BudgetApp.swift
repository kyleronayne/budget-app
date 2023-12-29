//
//  BudgetApp.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/28/23.
//

import SwiftUI

@main
struct BudgetApp: App {
    @ObservedObject private var navigationRouter = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .environmentObject(navigationRouter)
    }
}
