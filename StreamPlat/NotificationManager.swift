//
//  NotificationManager.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 15/12/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager()
    
    private init() { }
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error during permission request: \(error.localizedDescription)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }
    
    func scheduleNotifications(for item: PlatformItems) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let daysToNotify = [15, 3]
        for daysBefore in daysToNotify {
            guard let notificationDate = Calendar.current.date(byAdding: .day, value: -daysBefore, to: item.date) else { continue }
            
            let content = UNMutableNotificationContent()
            if daysBefore == 15 {
                content.title = "Reminder 15 days left"
                content.body = "You have 15 days left to use your subscription."
            } else if daysBefore == 3 {
                content.title = "Reminder 3 days left"
                content.body = "Remember to interrupt your subscription if you don't use it."
            }
            content.sound = .default
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(item.id)-\(daysBefore)days", content: content, trigger: trigger)
            
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Error during notification scheduling: \(error.localizedDescription)")
                } else {
                    print("Noification scheduled for \(daysBefore) days before the expiration date of \(item.title).")
                }
            }
        }
    }
}
