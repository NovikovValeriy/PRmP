//
//  ArithmeticOperation.swift
//  Calculator
//
//  Created by Валерий Новиков on 7.02.25.
//

import Foundation

enum ArithmeticOperation {
    case addition, subtraction, multiplication, division
    
    var description: String {
        switch self {
        case .addition:
            return "plus"
        case .subtraction:
            return "minus"
        case .multiplication:
            return "multiply"
        case .division:
            return "divide"
        }
    }
}
