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
    @State private var isExpanded = false
    private let chevronImageName = "chevron.down"
    private let pickerAccessibilityLabelName = "Month"
    
    private var labelPadding: Edge.Set {
        isExpanded ? [.top, .horizontal] : [.all]
    }
    
    private var chevronDegrees: CGFloat {
        isExpanded ? -180 : 0
    }
    
    private var pickerHeight: CGFloat? {
        isExpanded ? nil : 0
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }
            }) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(viewModel.selectedBudgetMonthString.month) ")
                        .font(.largeTitle.bold())
                    +
                    Text(viewModel.selectedBudgetMonthString.year)
                        .font(.headline.monospaced())
                    
                    Image(systemName: chevronImageName)
                        .font(.headline)
                        .rotationEffect(Angle(degrees: chevronDegrees))
                        .animation(.easeInOut, value: isExpanded)
                }
            }
            .padding(labelPadding)
            
            Picker(pickerAccessibilityLabelName, selection: $viewModel.selectedBudgetMonth) {
                ForEach(viewModel.availableBudgetMonths, id: \.self) { month in
                    Text(viewModel.makeMonthString(from: month))
                        .tag(month)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            .frame(height: pickerHeight, alignment: .bottom)
            .clipped()
        }
        .background(.white)
    }
}

#Preview {
    MonthPicker()
}
