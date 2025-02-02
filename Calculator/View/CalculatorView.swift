//
//  ContentView.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI

struct CalculatorView: View {
    
    private var buttons: [[ButtonType]] = [
        [.sine, .cosine, .tangent, .cotangent],
        [.clear, .negative, .percent, .root],
        [.seven, .eight, .nine, .divide],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .minus],
        [.zero, .dot, .equal, .plus]
    ]
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack{
                HStack {
                    Spacer()
                    Text("0")
                        .font(.system(size: 72))
                }
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            Button() {
                                
                            } label : {
                                Text(button.rawValue)
                            }
                            .frame(
                            .background(getButtonColor(button))
                            .cornerRadius(100)
                        }
                    }
                }
            }
        }
        .foregroundStyle(.white)
    }
    
    func getButtonColor(_ type: ButtonType) -> Color {
        switch type {
        case .sine, .cosine, .tangent, .cotangent:
            return Color("TrigonometryButtonColor")
        case .clear, .negative, .percent, .root:
            return Color("SecondaryButtonColor")
        case .divide, .multiply, .minus, .plus, .equal:
            return Color("OperatorButtonColor")
        default:
            return Color("PrimaryButtonColor")
        }
    }
}

#Preview {
    CalculatorView()
}
