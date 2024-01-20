//
//  BudgetTabView.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/28/23.
//

import SwiftUI

/// The tab view where a user can view and create monthly budgets
struct BudgetTabView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject private var viewModel = BudgetTabViewModel()
    
    var body: some View {
        NavigationStackView(.default, path: navigationRouter.navigationPath(forTab: .budget)) {
            VStack(alignment: .leading, spacing: 0) {
                MonthPicker()
                    .overlay(Divider(), alignment: .bottom)
                
                ScrollView {
                    VStack {
                        Button("Create Budget") {
                            viewModel.isShowingBudgetCreationView.toggle()
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .background(Color.background)
            }
            .sheet(isPresented: $viewModel.isShowingBudgetCreationView) {
                BudgetCreationView()
            }
        }
        .environmentObject(viewModel)
        .tag(Tab.budget)
        .tabItem {
            Label("Budget", systemImage: "dollarsign.square")
        }
    }
}

#Preview {
    BudgetTabView()
}
