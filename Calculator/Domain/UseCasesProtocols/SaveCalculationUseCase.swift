//
//  SaveCalculationUseCase.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

protocol SaveCalculationUseCase {
    func execute(_ calculation: Calculation, forUser userUID: String, completion: @escaping (Result<Void, Error>) -> Void)
}
