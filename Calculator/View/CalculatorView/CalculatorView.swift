//
//  ContentView.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI
import AVFoundation

struct CalculatorView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject private var viewModel: ViewModel
    
    @State private var shakeOffset: CGFloat = 0
    @State private var textOpacity = 1.0
    private let spacing: CGFloat = 15
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.background
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()
                    outputView
                    buttonGroup(geometry: geometry)
                }
            }
            .foregroundStyle(.white)
        }
    }
    
    private var outputView: some View {
        HStack() {
            Spacer()
            VStack {
                Text(viewModel.displayText)
                    .font(.system(size: verticalSizeClass == .regular ? 90 : 50, weight: .light))
                    .allowsTightening(true)
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .onShake {
                        viewModel.performAction(for: viewModel.clearShowingType)
                        viewModel.shakeText()
                    }
                    .offset(x: shakeOffset)
                    .opacity(textOpacity)
                
                    .animation(Animation.default.repeatCount(5, autoreverses: true), value: shakeOffset)
                    .onChange(of: viewModel.shouldShake) { newValue in
                        if newValue {
                            shakeText()
                        }
                    }
                
                    .animation(.linear.repeatCount(1, autoreverses: true).speed(5), value: textOpacity)
                    .onChange(of: viewModel.shouldDim) { newValue in
                        if newValue{
                            dimText()
                        }
                    }
            }
        }
        .padding([.trailing, .leading], spacing)
    }
    
    private func buttonGroup(geometry: GeometryProxy) -> some View {
        VStack(spacing: spacing) {
            ForEach(viewModel.buttons, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { button in
                        CalculatorButton(
                            spacing: spacing,
                            verticalSizeClass: verticalSizeClass,
                            geometry: geometry,
                            button: button,
                            action: {
                                viewModel.performAction(for: button)
                            },
                            foregroundColor: viewModel.buttonTypeIsHighlighted(buttonType: button) ? button.buttonColor : button.fontColor,
                            backgroundColor: viewModel.buttonTypeIsHighlighted(buttonType: button) ? button.fontColor : button.buttonColor
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func shakeText() {
        shakeOffset = -50
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            shakeOffset = 40
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                shakeOffset = -30
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    shakeOffset = 20
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        shakeOffset = 0
                    }
                }
            }
        }
    }
    
    private func dimText() {
        textOpacity = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            textOpacity = 1
        }
    }
}

struct CalculatorButton: View {
    let spacing: CGFloat
    let verticalSizeClass: UserInterfaceSizeClass?
    let geometry: GeometryProxy
    let button: ButtonType
    let action: () -> Void
    let foregroundColor: Color
    let backgroundColor: Color
    
    var body: some View {
        Button(action: action) {
            if UIImage(systemName: button.description) != nil {
                Image(systemName: button.description)
                    .font(.system(size: verticalSizeClass == .regular ? button.fontSize : 20))
                    .fontWeight(button.fontWeight)
                    .foregroundStyle(foregroundColor)
                    .frame(
                        width: buttonWidth(geometry),
                        height: buttonHeight(button, geometry)
                    )
            } else {
                Text(button.description)
                    .font(.system(size: verticalSizeClass == .regular ? button.fontSize : 20))
                    .fontWeight(button.fontWeight)
                    .foregroundStyle(foregroundColor)
                    .frame(
                        width: buttonWidth(geometry),
                        height: buttonHeight(button, geometry)
                    )
            }
        }
        .background(backgroundColor)
        .cornerRadius(100)
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
        
        if item.isTrigonometry {
            return (screenHeight - totalSpacing) / totalColumns / 2
        }
        
        return (screenHeight - totalSpacing) / totalColumns
    }
}

#Preview {
    CalculatorView()
        .environmentObject(CalculatorView.ViewModel())
}
