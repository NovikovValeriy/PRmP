//
//  ContentView.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI
import AVFoundation
import CoreHaptics

struct CalculatorView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @EnvironmentObject private var viewModel: ViewModel
    @Environment(\.scenePhase) var scenePhase
    
    @State private var shakeOffset: CGFloat = 0
    @State private var textOpacity = 1.0
    @State private var engine: CHHapticEngine?
    private let spacing: CGFloat = 15
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                NavigationStack {
                    VStack(spacing: 0) {
                        Spacer()
                        outputView
                        buttonGroup(geometry: geometry)
                    }
                    .background(Color.background)
//                    .toolbar {
//                        ToolbarItem(placement: .topBarTrailing){
//                            Button("Theme") {
//                                vibrate()
//                            }
//                        }
//                    }
                }
            }
        }
        .onAppear {
            prepareHapticsEngine()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                prepareHapticsEngine()
            } else if newPhase == .inactive || newPhase == .background {
                stopHaptics()
            }
        }
    }
    
    private var outputView: some View {
        HStack() {
            Spacer()
            VStack {
                Text(viewModel.displayText)
                    .foregroundStyle(Color.labelFont)
                    .font(.system(size: verticalSizeClass == .regular ? 90 : 50, weight: .light))
                    .allowsTightening(true)
                    .minimumScaleFactor(0.2)
                    .lineLimit(1)
                    .onShake {
                        viewModel.performAction(for: viewModel.clearShowingType)
                        viewModel.shakeText()
                        viewModel.vibrate()
                    }
                    .offset(x: shakeOffset)
                    .opacity(textOpacity)
                
                    .animation(Animation.default.repeatCount(5, autoreverses: true), value: shakeOffset)
                    .onChange(of: viewModel.shouldShake) { newValue in
                        if newValue {
                            shakeText()
                        }
                    }
                
                    .onChange(of: viewModel.shouldVibrate) { newValue in
                        if newValue {
                            vibrateSequence()
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
                                vibrate()
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
                    shakeOffset = 10
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
    
    func prepareHapticsEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            
            engine?.stoppedHandler = { reason in
                print("The engine stopped: \(reason)")
                do {
                    try self.engine?.start()
                } catch {
                    print("Failed to restart the engine: \(error)")
                }
            }
            
            try engine?.start()
        } catch {
            print("Error in creating haptic engine: \(error.localizedDescription)")
        }
    }
    
    func stopHaptics() {
        engine?.stop(completionHandler: { error in
            if let error = error {
                print("Error stopping the engine: \(error.localizedDescription)")
            } else {
                print("Haptic engine stopped successfully")
            }
        })
    }
    
    func vibrate() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
    
    func vibrateSequence() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 0.5, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
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
                return (screenHeight * 0.35 - totalSpacing) / 6
                
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
