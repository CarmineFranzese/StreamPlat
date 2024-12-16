//
//  Create1View.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 10/12/24.
//

import SwiftUI

struct Create1View: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @State private var item =  PlatformItems()
    
    var body: some View {
        List {
            TextField("Title", text: $item.title)
            TextField("Info", text: $item.info)
            DatePicker("Expiration Date", selection: $item.date, displayedComponents: .date)
            Button("Create") {
                withAnimation {
                    context.insert(item)
                }
                NotificationManager.shared.scheduleNotifications(for: item)
                dismiss()
            }
        }
        .navigationTitle("Add Subscription Card")
    }
}

#Preview {
    Create1View()
        .modelContainer(for: PlatformItems.self)
}
