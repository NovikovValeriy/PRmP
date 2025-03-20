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
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.primaryFont]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.primaryFont]
        UINavigationBar.appearance().barTintColor = UIColor.background
        //UINavigationBar.appearance().backItem?.backBarButtonItem?.tintColor = UIColor.operatorButton
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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Назад")
                    }
                    .foregroundStyle(Color.operatorButton)
                }
            )
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
