//
//  CalculationHistoryRepositoryImplementation.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

import Foundation
import FirebaseFirestore

class CalculationHistoryRepositoryImplementation: CalculationHistoryRepository {
    private let db = Firestore.firestore()
    
    func saveCalculation(_ calculation: Calculation, forUser userUID: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let data: [String: Any] = [
            "id": calculation.id,
            "firstOperand": calculation.firstOperand,
            "secondOperand": calculation.secondOperand,
            "operation": calculation.operation,
            "result": calculation.result,
            "timestamp": calculation.timestamp
        ]
        do {
            try db.collection("OperationHistory").document(userUID).collection("History").addDocument(from: calculation)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchCalculations(forUser userUID: String, completion: @escaping (Result<[Calculation], any Error>) -> Void) {
        db.collection("OperationHistory").document(userUID).collection("History").order(by: "timestamp", descending: true).getDocuments() { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let calculations = snapshot?.documents.compactMap { document -> Calculation? in
                    let data = document.data()
                    guard let id = data["id"] as? String,
                          let firstOperand = data["firstOperand"] as? String,
                          let secondOperand = data["secondOperand"] as? String,
                          let operation = data["operation"] as? String,
                          let result = data["result"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp else {
                        return nil
                    }
                    return Calculation(id: id, firstOperand: firstOperand, secondOperand: secondOperand, operation: operation, result: result, timestamp: timestamp)
                } ?? []
                completion(.success(calculations))
            }
        }
    }
}
