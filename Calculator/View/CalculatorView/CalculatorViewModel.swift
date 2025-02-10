//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Валерий Новиков on 6.02.25.
//

import Foundation

extension CalculatorView {
    final class ViewModel: ObservableObject {
        
        @Published private var calculator = CalculatorNew()
        
        var displayText: String {
            return calculator.displayText
        }
        
        var displaySecondNumberText: String {
            return calculator.displaySecondNumberText ?? ""
        }
        
        var buttons: [[ButtonType]] {
            let clearType: ButtonType = calculator.showAllClear ? ButtonType.allClear : ButtonType.clear
            return [
                [.sine, .cosine, .tangent, .cotangent],
                [clearType, .negative, .percent, .root],
                [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.division)],
                [.digit(.four), .digit(.five), .digit(.six), .operation(.multiplication)],
                [.digit(.one), .digit(.two), .digit(.three), .operation(.subtraction)],
                [.decimal, .digit(.zero), .equals, .operation(.addition)]
            ]
        }
        
        func performAction(for buttonType: ButtonType) {
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(digit)
            case .operation(let operation):
                calculator.setOperation(operation)
            case .negative:
                calculator.toggleSign()
            case .percent:
                calculator.setPercent()
            case .decimal:
                calculator.setDecimal()
            case .equals:
                calculator.evaluate()
            case .allClear:
                calculator.allClear()
            case .clear:
                calculator.clear()
            case .sine:
                calculator.sine()
            case .cosine:
                calculator.cosine()
            case .tangent:
                calculator.tangent()
            case .cotangent:
                calculator.cotangent()
            case .root:
                calculator.root()
            }
        }
        
        func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
            guard case .operation(let operation) = buttonType else { return false }
            return calculator.operationIsHighlighted(operation)
        }
    }
}
