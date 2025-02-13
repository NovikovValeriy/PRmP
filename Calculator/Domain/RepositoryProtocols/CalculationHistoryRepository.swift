//
//  CalculationHistoryRepository.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

protocol CalculationHistoryRepository {
    func saveCalculation(_ calculation: Calculation, forUser userUID: String, completion: @escaping (Result<Void, Error>) -> Void)
    func fetchCalculations(forUser userUID: String, completion: @escaping (Result<[Calculation], Error>) -> Void)
}
