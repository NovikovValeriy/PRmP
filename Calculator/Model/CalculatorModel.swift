//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Валерий Новиков on 7.02.25.
//

import Foundation

struct CalculatorModel {
    
    // MARK: Properties
    private var currentNumber: Decimal = 0
    private var secondNumber: Decimal?
    
    private var pendingOperation: ArithmeticOperation?
    private var previousOperation: ArithmeticOperation?
    
    private var operationPressed: Bool = false
    private var operationJustPressed: Bool = false
    private var showClear: Bool = false
    private var showingResult: Bool = false
    private var noExponentOputput: Bool = false
    
    private var decimalPressed: Bool = false
    private var carryingZeroes: Int = 0
    
    // MARK: Computed properties
    var displayText: String {
        return getNumberString(forNumber: currentNumber, withCommas: true)
    }
    
    var displaySecondNumberText: String? {
        if let secondNumber = secondNumber {
            return getNumberString(forNumber: secondNumber, withCommas: true)
        } else {
            return nil
        }
    }
    
    var showAllClear: Bool {
        return !showClear
    }
    
    var checkDigitsCount: Bool {
        var decimalPart = 0
        let text = displayText
        if text.contains("e") {
            return false
        }
        if text.contains(",") || text.contains(".") {
            decimalPart = 1
        }
        if text.components(separatedBy: " ").joined().count - decimalPart >= 9 {
            return false
        }
        return true
    }
    
    var isOperationSelected: Bool {
        return pendingOperation != nil
    }
    
    // MARK: Methods
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return pendingOperation == operation
    }
    
    mutating func setDigit(_ digit: Digit) {
        noExponentOputput = false
        
        if operationJustPressed || showingResult {
            currentNumber = 0
            carryingZeroes = 0
            operationJustPressed = false
            showingResult = false
        }
        
        guard checkDigitsCount else { return }
        
        if decimalPressed {
            if digit == .zero {
                carryingZeroes += 1
            } else {
                currentNumber = Decimal(string: displayText.replacingOccurrences(of: ",", with: ".") + "\(digit.rawValue)")!
                carryingZeroes = 0
            }
            return
        }
        
        let numberString = getNumberString(forNumber: currentNumber)
        currentNumber = Decimal(string: numberString.appending("\(digit.rawValue)").replacingOccurrences(of: ",", with: "."))!
        showClear = true
    }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        noExponentOputput = false
        if pendingOperation != nil {
            evaluate()
        }
        secondNumber = currentNumber
        pendingOperation = operation
        previousOperation = nil
        operationJustPressed = true
        operationPressed = true
        decimalPressed = false
    }
    
    mutating func toggleSign() {
        currentNumber *= -1
    }
    
    mutating func setPercent() {
        noExponentOputput = false
        currentNumber /= 100
        showingResult = true
        decimalPressed = false
    }
    
    mutating func setDecimal() {
        guard checkDigitsCount else { return }
        noExponentOputput = false
        decimalPressed = true
        showClear = true
    }
    
    mutating func evaluate(equalPressed: Bool = false) {
        noExponentOputput = false
        guard (
            pendingOperation == nil && previousOperation != nil || pendingOperation != nil && previousOperation == nil
        ) && secondNumber != nil else { return }
        var result: Decimal = 0
        if previousOperation != nil {
            result = switchOperation(operation: previousOperation!, firstOperand: currentNumber, secondOperand: secondNumber!)
        } else {
            result = switchOperation(operation: pendingOperation!, firstOperand: secondNumber!, secondOperand: currentNumber)
            previousOperation = pendingOperation
            pendingOperation = nil
        }
        decimalPressed = false
        carryingZeroes = 0
        if result.isNaN {
            secondNumber = nil
            currentNumber = 0
        }
        if !showingResult {
            secondNumber = currentNumber
            showingResult = true
        }
        currentNumber = result
    }
    
    private func switchOperation(operation: ArithmeticOperation, firstOperand: Decimal, secondOperand: Decimal) -> Decimal {
        var result: Decimal = 0
        switch operation {
        case .addition:
            result = firstOperand + secondOperand
        case .subtraction:
            result = firstOperand - secondOperand
        case .division:
            result = firstOperand / secondOperand
        case .multiplication:
            result = firstOperand * secondOperand
        }
        return result
    }
    
    mutating func allClear() {
        noExponentOputput = false
        currentNumber = 0
        carryingZeroes = 0
        secondNumber = nil
        pendingOperation = nil
        operationJustPressed = false
        operationPressed = false
        showClear = false
        decimalPressed = false
    }
    
    mutating func clear() {
        noExponentOputput = false
        currentNumber = 0
        carryingZeroes = 0
        decimalPressed = false
        showClear = false
    }
    
    mutating func sine() {
        let doubleValue = NSDecimalNumber(decimal: currentNumber).doubleValue
        let sinValue = sin(doubleValue)
        currentNumber = Decimal(sinValue)
        noExponentOputput = true
        showingResult = true
        decimalPressed = false
        carryingZeroes = 0
        return
    }
    
    mutating func cosine() {
        let doubleValue = NSDecimalNumber(decimal: currentNumber).doubleValue
        let sinValue = sin(doubleValue)
        currentNumber = Decimal(sinValue)
        noExponentOputput = true
        showingResult = true
        decimalPressed = false
        carryingZeroes = 0
        return
    }
    
    mutating func tangent() {
        let doubleValue = NSDecimalNumber(decimal: currentNumber).doubleValue
        let sinValue = tan(doubleValue)
        currentNumber = Decimal(sinValue)
        noExponentOputput = true
        showingResult = true
        decimalPressed = false
        carryingZeroes = 0
        return
    }
    
    mutating func cotangent() {
        let doubleValue = NSDecimalNumber(decimal: currentNumber).doubleValue
        let sinValue = Decimal(sin(doubleValue))
        let cosValue = Decimal(cos(doubleValue))
        let cotanValue = cosValue / sinValue
        currentNumber = cotanValue
        noExponentOputput = true
        showingResult = true
        decimalPressed = false
        carryingZeroes = 0
        return
    }
    
    mutating func root() {
        let doubleValue = NSDecimalNumber(decimal: currentNumber).doubleValue
        let rootValue = sqrt(doubleValue)
        currentNumber = Decimal(rootValue)
        noExponentOputput = true
        showingResult = true
        decimalPressed = false
        carryingZeroes = 0
        return
    }
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        if number?.isNaN ?? false {
            return "Ошибка"
        }
        let numberString = String(describing: number ?? 0)
        let numberPartsArray = numberString.split(separator: ".")
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator ?? "."
        numberFormatter.groupingSeparator = " "
        numberFormatter.minusSign = "–"
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 9
        if (
            (numberPartsArray.count > 1 && numberPartsArray[1].count > 9)
            ||
            (numberPartsArray.count == 1 && numberString.count > 9)
        )
            &&
            !noExponentOputput
        {
            numberFormatter.numberStyle = .scientific
            numberFormatter.exponentSymbol = "e"
        }
        let formattedNumber = numberFormatter.string(from: (number ?? 0) as NSDecimalNumber) ?? ""
        var result = (withCommas ? formattedNumber : number.map(String.init)) ?? "0"
                
        if decimalPressed && !result.contains(Locale.current.decimalSeparator ?? ".") && !result.contains(".") {
            result += Locale.current.decimalSeparator ?? "."
        }
        
        if carryingZeroes > 0 {
            result.append(String(repeating: "0", count: carryingZeroes))
        }
        
        return result
    }
}
