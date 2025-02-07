//
//  ButtonType.swift
//  Calculator
//
//  Created by Валерий Новиков on 2.02.25.
//

import SwiftUI

enum ButtonType: Hashable, CustomStringConvertible {
    case digit(_ digit: Digit)
    case operation(_ operation: ArithmeticOperation)
    case negative
    case percent
    case sine
    case cosine
    case tangent
    case cotangent
    case root
    case decimal
    case equals
    case allClear
    case clear
    
    var description: String {
        switch self {
        case .digit(let digit):
            return digit.description
        case .operation(let operation):
            return operation.description
        case .negative:
            return "±"
        case .percent:
            return "%"
        case .decimal:
            return ","
        case .equals:
            return "="
        case .allClear:
            return "AC"
        case .clear:
            return "C"
        case .sine:
            return "sin"
        case .cosine:
            return "cos"
        case .tangent:
            return "tan"
        case .cotangent:
            return "cot"
        case .root:
            return "√"
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .sine, .cosine, .tangent, .cotangent:
            return Color.trigonometryButton
        case .allClear, .clear, .negative, .percent, .root:
            return Color.secondaryButton
        case .operation, .equals:
            return Color.operatorButton
        default:
            return Color.primaryButton
        }
    }
    
    var fontColor: Color {
        switch self {
        case .allClear, .clear, .negative, .percent, .root:
            return Color.black
        default:
            return Color.white
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .sine, .cosine, .tangent, .cotangent:
            return 25
        default:
            return 35
        }
    }
}
