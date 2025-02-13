//
//  SaveCalculationUseCaseImpl.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

class SaveCalculationUseCaseImpl {
    private let repository: CalculationHistoryRepository
    
    init(repository: CalculationHistoryRepository) {
        self.repository = repository
    }
    
    func execute(_ calculation: Calculation, forUser userUID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.saveCalculation(calculation, forUser: userUID, completion: completion)
    }
}
