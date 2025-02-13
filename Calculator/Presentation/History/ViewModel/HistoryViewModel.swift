//
//  HistoryViewModel.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

import Foundation
import SwiftUI

final class HistoryViewModel: ObservableObject {
    @AppStorage("app_id") private var appId: String?
    @Published var history: [Calculation] = []
    @Published var errorMessage: String = ""
    
    private let fetchCalculationsUseCase: FetchCalculationsUseCase
    //private let saveCalculationUseCase: SaveCalculationUseCase
    
    init(
        fetchCalculationsUseCase: FetchCalculationsUseCase
        //saveCalculationUseCase: SaveCalculationUseCase
    ) {
        self.fetchCalculationsUseCase = fetchCalculationsUseCase
        //self.saveCalculationUseCase = saveCalculationUseCase
    }
    
//    func saveCalculation(_ calculation: Calculation) {
//        saveCalculationUseCase.execute(calculation, forUser: appId ?? "") { [weak self] result in
//            switch result {
//            case .success:
//                self?.fetchHistory()
//            case .failure(let error):
//                self?.errorMessage = error.localizedDescription
//            }
//        }
//    }

    func fetchHistory() {
        fetchCalculationsUseCase.execute(forUser: appId ?? "") { [weak self] result in
            switch result {
            case .success(let calculations):
                self?.history = calculations
                print(self?.history)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
