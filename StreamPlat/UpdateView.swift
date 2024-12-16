//
//  UpdateView.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 13/12/24.
//

import SwiftUI
import SwiftData

struct UpdateView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var item: PlatformItems
    
    var body: some View {
        List {
            TextField("Title", text: $item.title)
            TextField("Info", text: $item.info)
            DatePicker("Expiration Date", selection: $item.date, displayedComponents: .date)
            Button("Update") {
                dismiss()
                NotificationManager.shared.scheduleNotifications(for: item)
            }
        }
        .navigationTitle("Update")
    }
}
