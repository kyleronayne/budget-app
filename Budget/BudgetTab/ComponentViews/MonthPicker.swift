//
//  MonthPicker.swift
//  Budget
//
//  Created by Kyle Ronayne on 12/29/23.
//

import SwiftUI

/// A view that expands and collapses to show a wheel-style month picker
struct MonthPicker: View {
    @EnvironmentObject private var viewModel: BudgetTabViewModel
    @State private var isShowingPicker = false
    
    private var chevronDegrees: CGFloat {
        isShowingPicker ? -180 : 0
    }
    
    private var pickerHeight: CGFloat {
        isShowingPicker ? 150 : 0
    }
    
    private var pickerOpacity: CGFloat {
        isShowingPicker ? 1 : 0
    }
    
    private var contentPadding: Edge.Set {
        isShowingPicker ? [.top, .horizontal] : [.all]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Button(action: {
                    withAnimation(.easeInOut) {
                        isShowingPicker.toggle()
                    }
                }) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(viewModel.makeAttributedMonthString(from: viewModel.selectedBudgetMonth))
                        
                        Image(systemName: "chevron.down")
                            .font(.callout)
                            .rotationEffect(Angle(degrees: chevronDegrees))
                            .animation(.easeInOut, value: isShowingPicker)
                    }
                }
            }
            
            Picker("Month", selection: $viewModel.selectedBudgetMonth) {
                ForEach(viewModel.budgetMonths, id: \.self) { month in
                    Text(String(viewModel.makeAttributedMonthString(from: month).characters[...]))
                        .tag(month)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            .frame(height: pickerHeight)
            .opacity(pickerOpacity)
        }
        .padding(contentPadding)
        .background(.white)
    }
}

#Preview {
    MonthPicker()
}
