//
//  BudgetTabView.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/28/23.
//

import SwiftUI

struct BudgetTabView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject private var viewModel = BudgetTabViewModel()
    
    var body: some View {
        NavigationStackView(.default, path: navigationRouter.navigationPath(forTab: .budget)) {
            ScrollView {
                VStack {
                    Text("Hello, world!")
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Budget")
            .background(Color.background)
        }
        .tag(Tab.budget)
        .environmentObject(viewModel)
        .tabItem {
            Label("Budget", systemImage: "dollarsign.square")
        }
    }
}

#Preview {
    BudgetTabView()
}
