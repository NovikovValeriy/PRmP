//
//  HistoryView.swift
//  Calculator
//
//  Created by Валерий Новиков on 13.02.25.
//

import SwiftUI
import UIKit

struct HistoryView: View {
//    @StateObject private var viewModel = HistoryViewModel(
//        fetchCalculationsUseCase: FetchCalculationsUseCaseImpl(repository: CalculationHistoryRepositoryImplementation()),
//        saveCalculationUseCase: SaveCalculationUseCaseImpl(repository: CalculationHistoryRepositoryImplementation())
//    )
    @ObservedObject var viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.primaryFont]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.primaryFont]
        UINavigationBar.appearance().barTintColor = UIColor.background
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    Form{
                        Section{
                            ForEach(viewModel.history, id: \.id) { calculation in
                                Text("\(calculation.firstOperand) \(calculation.operation) \(calculation.secondOperand) = \(calculation.result)")
                                    .foregroundStyle(Color.primaryFont)
                            }
                        }
                        .listRowBackground(Color.primaryButton)
                        .listRowSeparatorTint(Color.secondaryButton)
                    }
                    .scrollContentBackground(.hidden)
                }
                .background(Color.background)
                .navigationTitle("История")
            }
            .onAppear {
                viewModel.fetchHistory()
            }
        }
    }
}

#Preview {
    HistoryView(
        viewModel: HistoryViewModel(
            fetchCalculationsUseCase: FetchCalculationsUseCaseImpl(
                repository: FakeCalculationHistoryRepositoryImpl()
            )
//            saveCalculationUseCase: SaveCalculationUseCaseImpl(
//                repository: FakeCalculationHistoryRepositoryImpl()
//            )
        )
    )
}
