//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .environmentObject(CalculatorView.ViewModel())
        }
    }
}
