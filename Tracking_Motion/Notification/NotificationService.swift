//
//  NotificationService.swift
//  Tracking_Motion
//
//  Created by Manisha Kumari on 30/04/25.
//

import Foundation
import UserNotifications

class NotificationService {
    
    static func showNotification(title: String, body: String) {
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { allow, error in
            if allow {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default

                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                let request = UNNotificationRequest(identifier: "local", content: content, trigger: trigger)

                notificationCenter.add(request) { error in
                    if let error = error {
                        print("Error adding notification: \(error.localizedDescription)")
                    }
                }
            } else {
                print("User doesn't allow the notifications: \(error?.localizedDescription ?? "No error")")
            }
        }
    }

}
