//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Валерий Новиков on 6.02.25.
//

import SwiftUI

struct CalculatorButtonView: View {
    let text: String
    let width: CGFloat
    let height: CGFloat
    let size: CGFloat
    let button: ButtonType
    
    var body: some View {
        Text(text)
            .font(.system(size: size))
            .foregroundStyle(button.fontColor)
            .frame(
                width: width,
                height: height
            )
    }
}
