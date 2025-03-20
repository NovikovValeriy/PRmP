//
//  NotificationViewModel.swift
//  Calculator
//
//  Created by Валерий Новиков on 20.03.25.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationViewModel: ObservableObject {
    private let repository: NotificationRepository
    private let center = UNUserNotificationCenter.current()
    
    init(repository: NotificationRepository) {
        self.repository = repository
        requestNotificationPermission()
        observeNotifications()
    }
    
    private func observeNotifications() {
        repository.observeItems { [weak self] newItem in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.sendLocalNotification(title: newItem.title, body: newItem.body)
            }
        }
    }
    
    private func requestNotificationPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение на уведомления получено")
            } else if let error = error {
                print("Ошибка при запросе разрешения: \(error.localizedDescription)")
            }
        }
    }
    
    private func sendLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление успешно запланировано")
            }
        }
    }
}
