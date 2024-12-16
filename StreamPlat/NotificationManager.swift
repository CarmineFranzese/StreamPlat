//
//  NotificationManager.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 15/12/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let shared = NotificationManager() // Singleton (facile accesso ovunque nell'app)
    
    private init() { } // Impedisce la creazione di altre istanze

    // Richiede il permesso per le notifiche
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Errore durante la richiesta di autorizzazione: \(error.localizedDescription)")
            } else {
                print("Permesso concesso: \(granted)")
            }
        }
    }

    // Pianifica le notifiche per 15 e 3 giorni prima della scadenza
    func scheduleNotifications(for item: PlatformItems) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        let daysToNotify = [15, 3]
        for daysBefore in daysToNotify {
            guard let notificationDate = Calendar.current.date(byAdding: .day, value: -daysBefore, to: item.date) else { continue }
            
            let content = UNMutableNotificationContent()
            if daysBefore == 15 {
                content.title = "Promemoria: 15 giorni rimasti"
                content.body = "Hai ancora 15 giorni per usufruire di questo servizio."
            } else if daysBefore == 3 {
                content.title = "Promemoria: 3 giorni rimasti"
                content.body = "Ricordati di disattivare il rinnovo automatico se desideri terminare la sottoscrizione."
            }
            content.sound = .default
            
            let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(item.id)-\(daysBefore)days", content: content, trigger: trigger)
            
            notificationCenter.add(request) { error in
                if let error = error {
                    print("Errore durante la pianificazione della notifica: \(error.localizedDescription)")
                } else {
                    print("Notifica pianificata per \(daysBefore) giorni prima della scadenza di \(item.title).")
                }
            }
        }
    }
}
