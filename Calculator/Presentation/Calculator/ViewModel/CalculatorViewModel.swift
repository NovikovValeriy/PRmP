//
//  CalculatorViewModel.swift
//  Calculator
//
//  Created by Валерий Новиков on 6.02.25.
//

import Foundation
import SwiftUI
import AVFoundation
import CoreHaptics
import FirebaseCore

final class CalculatorViewModel: ObservableObject {
    @AppStorage("app_id") var AppUIID: String?
    @Published private var calculator = CalculatorModel()
    @Published var shouldShake: Bool = false
    @Published var shouldDim: Bool = false
    @Published var shouldVibrate: Bool = false
    
    private let saveCalculationUseCase: SaveCalculationUseCase
    
    init(saveCalculationUseCase: SaveCalculationUseCase) {
        self.saveCalculationUseCase = saveCalculationUseCase
    }
    
    var displayText: String {
        return calculator.displayText
    }
    
    var displaySecondNumberText: String {
        return calculator.displaySecondNumberText ?? ""
    }
    
    var clearShowingType: ButtonType {
        return calculator.showAllClear ? ButtonType.allClear : ButtonType.clear
    }
    
    var buttons: [[ButtonType]] {
        let clearType: ButtonType = clearShowingType
        return [
            [.trigonometry(.sine), .trigonometry(.cosine), .trigonometry(.tangent), .trigonometry(.cotangent)],
            [clearType, .negative, .percent, .root],
            [.digit(.seven), .digit(.eight), .digit(.nine), .operation(.division)],
            [.digit(.four), .digit(.five), .digit(.six), .operation(.multiplication)],
            [.digit(.one), .digit(.two), .digit(.three), .operation(.subtraction)],
            [.decimal, .digit(.zero), .equals, .operation(.addition)]
        ]
    }
    
    func shakeText(){
        shouldShake = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldShake = false
        }
    }
    
    func vibrate(){
        shouldVibrate = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldVibrate = false
        }
    }
    
    private func dimText(){
        shouldDim = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.shouldDim = false
        }
    }
    
    
    func performAction(for buttonType: ButtonType) {
        switch buttonType {
        case .digit(let digit):
            calculator.setDigit(digit)
        case .operation(let operation):
            calculator.setOperation(operation)
        case .trigonometry(let trigonometry):
            switch trigonometry {
                case .sine:
                    calculator.sine()
                case .cosine:
                    calculator.cosine()
                case .tangent:
                    calculator.tangent()
                case .cotangent:
                    calculator.cotangent()
            }
        case .negative:
            calculator.toggleSign()
        case .percent:
            calculator.setPercent()
        case .decimal:
            calculator.setDecimal()
        case .equals:
            let isOperationSelected = calculator.isOperationSelected
            let prev = calculator.displayText
            
            let firstOperand = calculator.displaySecondNumberText
            let secondOperand = calculator.displayText
            let operation = calculator.selectedOperationText
            calculator.evaluate()
            if calculator.displayText != "Ошибка" {
                let result = calculator.displayText
                saveCalculationUseCase.execute(Calculation(id: UUID().uuidString, firstOperand: firstOperand ?? "", secondOperand: secondOperand, operation: operation ?? "", result: result, timestamp: Timestamp(date: Date.now)), forUser: AppUIID ?? "", completion: { _ in })
            }
            if calculator.displayText == prev && isOperationSelected {
                dimText()
            }
        case .allClear:
            calculator.allClear()
        case .clear:
            calculator.clear()
        case .root:
            calculator.root()
        }
        AudioServicesPlaySystemSound(1104)
        
    }
    
    func buttonTypeIsHighlighted(buttonType: ButtonType) -> Bool {
        guard case .operation(let operation) = buttonType else { return false }
        return calculator.operationIsHighlighted(operation)
    }
}
