//
//  FakeCalculationHistoryRepositoryImpl.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

import Foundation
import FirebaseFirestore

class FakeCalculationHistoryRepositoryImpl: CalculationHistoryRepository {
    
    func saveCalculation(_ calculation: Calculation, forUser userUID: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        completion(.success(()))
    }
    
    func fetchCalculations(forUser userUID: String, completion: @escaping (Result<[Calculation], any Error>) -> Void) {
        let calculations: [Calculation] = [
            .init(id: "1", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "2", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "3", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "4", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "5", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "6", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "7", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "8", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "9", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "10", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "11", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "12", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "13", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "14", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "15", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "16", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "17", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "18", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "19", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "20", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "21", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "22", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "23", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "24", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "25", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "26", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "27", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "28", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "29", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "30", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "31", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "32", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "33", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "34", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "35", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "36", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "37", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "38", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "39", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
            .init(id: "40", firstOperand: "999 999 999", secondOperand: "999 999 999", operation: "+", result: "999 999 999", timestamp: Timestamp(date: Date.now)),
        ]
        completion(.success(calculations))
    }
}
