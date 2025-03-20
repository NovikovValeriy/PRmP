//
//  NotificationRepositoryImplementation.swift
//  Calculator
//
//  Created by Валерий Новиков on 20.03.25.
//

import FirebaseDatabase

class NotificationRepositoryImplementation: NotificationRepository {
    private var databaseReference: DatabaseReference!
    
    init() {
        databaseReference = Database.database().reference()
        print(databaseReference.url)
    }
    
    func observeItems(completion: @escaping (NotificationItem) -> Void) {
        databaseReference.child("notifications").observe(.childChanged) { snapshot in
            guard let value = snapshot.value as? [String: Any],
                  let title = value["title"] as? String,
                  let body = value["body"] as? String else {
                print("Некорректные данные в записи")
                return
            }
            let item = NotificationItem(id: snapshot.key, title: title, body: body)
            completion(item)
        }
    }
    
    
}
