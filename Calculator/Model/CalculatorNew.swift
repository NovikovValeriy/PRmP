//
//  Calculator 2.swift
//  Calculator
//
//  Created by Валерий Новиков on 7.02.25.
//


import Foundation

struct Calculator {
    
    private struct ArithmeticExpression: Equatable {
            var number: Decimal
            var operation: ArithmeticOperation

            func evaluate(with secondNumber: Decimal) -> Decimal {
                let result: Decimal
                switch operation {
                case .addition:
                    result =  number + secondNumber
                case .subtraction:
                    result = number - secondNumber
                case .multiplication:
                    result =  number * secondNumber
                case .division:
                    result =  number / secondNumber
                }
                return result
            }
        }
    
    private var newNumber: Decimal? {
        didSet {
            guard newNumber != nil else { return }
            carryingNegative = false
            carryingDecimal = false
            carryingZeroCount = 0
            pressedClear = false
        }
    }
    private var expression: ArithmeticExpression?
    private var result: Decimal?
    private var carryingNegative: Bool = false
    private var carryingDecimal: Bool = false
    private var carryingZeroCount: Int = 0
    
    private var pressedClear: Bool = false
    
    var displayText: String {
        return getNumberString(forNumber: number, withCommas: true)
    }
    
    var showAllClear: Bool {
        newNumber == nil && expression == nil && result == nil || pressedClear
    }
    
    var number: Decimal? {
        if pressedClear || carryingDecimal {
            return newNumber
        }
        return newNumber ?? expression?.number ?? result
    }
    
    private var containsDecimal: Bool {
        return getNumberString(forNumber: number).contains(Locale.current.decimalSeparator ?? ".")
    }
    
    mutating func setDigit(_ digit: Digit) {
        if containsDecimal && digit == .zero {
            carryingZeroCount += 1
        } else if canAddDigit(digit) {
            let numberString = getNumberString(forNumber: newNumber)
            newNumber = Decimal(string: numberString.appending("\(digit.rawValue)").replacingOccurrences(of: ",", with: "."))
        }
    }
    
    mutating func setOperation(_ operation: ArithmeticOperation) {
        guard var number = newNumber ?? result else { return }
        if let existingExpression = expression {
            number = existingExpression.evaluate(with: number)
        }
        expression = ArithmeticExpression(number: number, operation: operation)
        newNumber = nil
    }
    
    mutating func toggleSign() {
        if let number = newNumber {
            newNumber = -number
            return
        }
        if let number = result {
            result = -number
            return
        }

        carryingNegative.toggle()
    }
    
    mutating func setPercent() {
        if let number = newNumber {
            newNumber = number / 100
            return
        }
        
        if let number = result {
            result = number / 100
            return
        }
    }
    
    mutating func setDecimal() {
        if containsDecimal { return }
        carryingDecimal = true
    }
    
    mutating func evaluate() {
        guard let number = newNumber, let expressionToEvaluate = expression else { return }
        result = expressionToEvaluate.evaluate(with: number)
        expression = nil
        newNumber = nil
    }
    
    mutating func allClear() {
        newNumber = nil
        expression = nil
        result = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
    }
    
    mutating func clear() {
        newNumber = nil
        carryingNegative = false
        carryingDecimal = false
        carryingZeroCount = 0
        
        pressedClear = true
    }
    
    mutating func sine() {
        if let number = newNumber {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let sinValue = sin(doubleValue)
            newNumber = Decimal(sinValue)
            return
        }
        
        if let number = result {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let sinValue = sin(doubleValue)
            result = Decimal(sinValue)
            return
        }
    }
    
    mutating func cosine() {
        if let number = newNumber {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let cosValue = cos(doubleValue)
            newNumber = Decimal(cosValue)
            return
        }
        
        if let number = result {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let cosValue = cos(doubleValue)
            result = Decimal(cosValue)
            return
        }
    }
    
    mutating func tangent() {
        if let number = newNumber {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let tanValue = tan(doubleValue)
            newNumber = Decimal(tanValue)
            return
        }
        
        if let number = result {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let tanValue = tan(doubleValue)
            result = Decimal(tanValue)
            return
        }
    }
    
    mutating func cotangent() {
        if let number = newNumber {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let sinValue = sin(doubleValue)
            let cosValue = cos(doubleValue)
            let cotanValue = cosValue / sinValue
            newNumber = Decimal(cotanValue)
            return
        }
        
        if let number = result {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let sinValue = sin(doubleValue)
            let cosValue = cos(doubleValue)
            let cotanValue = cosValue / sinValue
            result = Decimal(cotanValue)
            return
        }
    }
    
    mutating func root() {
        if let number = newNumber {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let rootValue = sqrt(doubleValue)
            newNumber = Decimal(rootValue)
            return
        }
        
        if let number = result {
            let doubleValue = NSDecimalNumber(decimal: number).doubleValue
            let rootValue = sqrt(doubleValue)
            newNumber = Decimal(rootValue)
            return
        }
    }
    
    func operationIsHighlighted(_ operation: ArithmeticOperation) -> Bool {
        return expression?.operation == operation && newNumber == nil
    }
    
    private func getNumberString(forNumber number: Decimal?, withCommas: Bool = false) -> String {
        if number?.isNaN ?? false {
            return "Ошибка"
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator ?? "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 9
        let formattedNumber = numberFormatter.string(from: (number ?? 0) as NSDecimalNumber) ?? ""
        var numberString = (withCommas ? formattedNumber : number.map(String.init)) ?? "0"
        //var numberString = (withCommas ? number?.formatted(.number) : number.map(String.init)) ?? "0"
                
        if carryingNegative {
            numberString.insert("-", at: numberString.startIndex)
        }
        
        if carryingDecimal {
            numberString.insert(Character(Locale.current.decimalSeparator ?? "."), at: numberString.endIndex)
        }
        
        if carryingZeroCount > 0 {
            numberString.append(String(repeating: "0", count: carryingZeroCount))
        }
        
        return numberString
    }

    private func canAddDigit(_ digit: Digit) -> Bool {
        return number != nil || digit != .zero
    }
}
