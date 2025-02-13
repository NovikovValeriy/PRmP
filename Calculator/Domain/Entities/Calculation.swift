//
//  Calculation.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//
import Foundation
import Firebase

struct Calculation: Identifiable, Codable {
    var id: String
    var firstOperand: String
    var secondOperand: String
    var operation: String
    var result: String
    var timestamp: Timestamp
}
