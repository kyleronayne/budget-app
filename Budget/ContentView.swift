//
//  ContentView.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        TabView(selection: $navigationRouter.activeTab) {
            Group {
                BudgetTabView()
            }
            .tabBarBackgroundColor(.white)
        }
        .tint(.green)
    }
}

#Preview {
    ContentView()
}
