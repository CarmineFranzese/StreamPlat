//
//  SettingsView.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 15/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isDarkMode: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                        .font(.title2)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView(isDarkMode: .constant(false))
}
