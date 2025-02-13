//
//  FetchCalculationsUseCase.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

protocol FetchCalculationsUseCase {
    func execute(forUser userUID: String, completion: @escaping (Result<[Calculation], Error>) -> Void)
}
