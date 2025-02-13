//
//  FetchCalculationsUseCaseImpl.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

class FetchCalculationsUseCaseImpl: FetchCalculationsUseCase {
    private let repository: CalculationHistoryRepository
    
    init(repository: CalculationHistoryRepository) {
        self.repository = repository
    }
    
    func execute(forUser userUID: String, completion: @escaping (Result<[Calculation], Error>) -> Void) {
        repository.fetchCalculations(forUser: userUID, completion: completion)
    }
}
