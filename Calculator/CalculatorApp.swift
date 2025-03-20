//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Валерий Новиков on 1.02.25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    // Обработка уведомлений на переднем плане
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Показываем уведомление как alert и звук
        completionHandler([.banner, .sound])
    }
}

@main
struct CalculatorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("app_id") var appUUID = ""
    
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
        }
    }
}
