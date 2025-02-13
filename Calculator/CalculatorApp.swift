//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI
import FirebaseCore

//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//
//    return true
//  }
//}

@main
struct CalculatorApp: App {
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("app_id") var appUUID = ""
    @StateObject var calculatorViewModel = CalculatorViewModel(saveCalculationUseCase: SaveCalculationUseCaseImpl(repository: CalculationHistoryRepositoryImplementation()))
    
    init() {
        FirebaseApp.configure()
        if appUUID.isEmpty {
            appUUID = UUID().uuidString
            print("Created new app UUID: \(appUUID)")
        }
        print("App UUID: \(appUUID)")
    }
    
    var body: some Scene {
        WindowGroup {
            CalculatorView()
//                .environmentObject(calculatorViewModel)
        }
    }
}
