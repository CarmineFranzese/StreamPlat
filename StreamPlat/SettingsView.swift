//
//  SettingsView.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 15/12/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isDarkMode: Bool // Collegamento alla variabile principale
    
    var body: some View {
        NavigationStack {
            VStack {
                Toggle(isOn: $isDarkMode) { // Interruttore per cambiare la modalità
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
    SettingsView(isDarkMode: .constant(false)) // Anteprima con stato falso per la modalità scura
}
