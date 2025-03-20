//
//  NotificationRepository.swift
//  Calculator
//
//  Created by Валерий Новиков on 20.03.25.
//

protocol NotificationRepository {
    func observeItems(completion: @escaping (NotificationItem) -> Void)
}
