//
//  BudgetCreationView.swift
//  Budget
//
//  Created by Kyle Ronayne on 1/17/24.
//

import SwiftUI

/// A view that guides the user through the budget creation steps
struct BudgetCreationView: View {
    @StateObject var viewModel = BudgetCreationViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back") {
                    viewModel.didTapBackButton()
                }
                Spacer()
                Button("Next") {
                    viewModel.didTapNextButton()
                }
            }
            .padding()
            
            GeometryReader { geometryProxy in
                ScrollViewReader { scrollViewProxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(viewModel.steps) { step in
                                step.view
                                    .frame(width: geometryProxy.size.width)
                                    .id(step)
                                    .environmentObject(viewModel)
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .ignoresSafeArea()
                    .onChange(of: viewModel.currentStep) { (_, step) in
                        withAnimation(.smooth) {
                            scrollViewProxy.scrollTo(step)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BudgetCreationView()
}
