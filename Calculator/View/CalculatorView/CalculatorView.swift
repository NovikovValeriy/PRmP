//
//  ContentView.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI

struct CalculatorView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject private var viewModel: ViewModel
    
    private let spacing: CGFloat = 15
    
    private var previousNumber: Double = 0
    private var currentNumber: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Color.background
                    .ignoresSafeArea()
                

                VStack(spacing: 0) {
                    Spacer()
                    HStack() {
                        Spacer()
                        VStack {
                            Text(viewModel.displaySecondNumberText)
                                .font(.system(size: verticalSizeClass == .regular ? 90 : 50, weight: .light))
                                .allowsTightening(true)
                                .minimumScaleFactor(0.2)
                                .lineLimit(1)
                            Text(viewModel.displayText)
                                .font(.system(size: verticalSizeClass == .regular ? 90 : 50, weight: .light))
                                .allowsTightening(true)
                                .minimumScaleFactor(0.2)
                                .lineLimit(1)
                        }
                    }
                    .padding([.trailing, .leading], spacing)
                    
                    VStack(spacing: spacing) {
                        ForEach(viewModel.buttons, id: \.self) { row in
                            HStack(spacing: spacing) {
                                ForEach(row, id: \.self) { button in
                                    Button() {
                                        viewModel.performAction(for: button)
                                    } label : {
                                        if UIImage(systemName: button.description) != nil {
                                            Image(systemName: button.description)
                                                .font(.system(size: verticalSizeClass == .regular ? button.fontSize : 20))
                                                .fontWeight(button.fontWeight)
                                                .foregroundStyle(viewModel.buttonTypeIsHighlighted(buttonType: button) ? button.buttonColor : button.fontColor)
                                                .frame(
                                                    width: buttonWidth(geometry),
                                                    height: buttonHeight(button, geometry)
                                                )
                                        } else {
                                            Text(button.description)
                                                .font(.system(size: verticalSizeClass == .regular ? button.fontSize : 20))
                                                .fontWeight(button.fontWeight)
                                                .foregroundStyle(viewModel.buttonTypeIsHighlighted(buttonType: button) ? button.buttonColor : button.fontColor)
                                                .frame(
                                                    width: buttonWidth(geometry),
                                                    height: buttonHeight(button, geometry)
                                                )
                                        }
                                    }
                                    .background(viewModel.buttonTypeIsHighlighted(buttonType: button) ? button.fontColor : button.buttonColor)
                                    .cornerRadius(100)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .foregroundStyle(.white)
        }
    }
    
    func buttonWidth(_ geometry: GeometryProxy) -> CGFloat {
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = geometry.size.width + (verticalSizeClass == .regular ? geometry.safeAreaInsets.leading + geometry.safeAreaInsets.trailing : geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom)
        
        return (screenWidth - totalSpacing) / totalColumns
    }
    
    func buttonHeight(_ item: ButtonType, _ geometry: GeometryProxy) -> CGFloat {
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenHeight = geometry.size.width
        
        if let verticalSizeClass = verticalSizeClass {
            if verticalSizeClass == .compact {
                return (screenHeight * 0.4 - totalSpacing) / 6
                
            }
        }
        
        if item == .sine || item == .cosine || item == .tangent || item == .cotangent {
            return (screenHeight - totalSpacing) / totalColumns / 2
        }
        
        return (screenHeight - totalSpacing) / totalColumns
    }
}

#Preview {
    CalculatorView()
        .environmentObject(CalculatorView.ViewModel())
}
