//
//  FetchThemeColorsUseCase.swift
//  Calculator
//
//  Created by Валерий Новиков on 21.03.25.
//

protocol FetchThemeColorsUseCase {
    func execute(forUser userUID: String, completion: @escaping (Result<Void, Error>) -> Void) -> ThemeColors
}
