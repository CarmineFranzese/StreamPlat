//
//  ContentView.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 10/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @State private var showCreate = false
    @State private var showDeleteConfirmation = false
    @State private var selectedItem: PlatformItems? // L'elemento attualmente selezionato per la cancellazione
    @Query private var items: [PlatformItems]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]) {
                        ForEach(items) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.yellow)
                                    .frame(height: 100)
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.largeTitle)
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(item.info)
                                    if let daysRemaining = Calendar.current.dateComponents([.day], from: Date(), to: item.date).day {
                                        Text("\(daysRemaining) Days left")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                .padding()
                            }
                            .onLongPressGesture {
                                selectedItem = item // Imposta l'elemento selezionato
                                showDeleteConfirmation = true // Mostra la finestra di conferma
                            }
                        }
                    }
                    .padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        showCreate.toggle()
                    }, label: {
                        Label("Add Item", systemImage: "plus.circle.fill")
                    })
                }
            }
        }
        .sheet(isPresented: $showCreate) {
            NavigationStack {
                Create1View()
                    .presentationDetents([.medium])
            }
        }
        .alert("Conferma eliminazione", isPresented: $showDeleteConfirmation, actions: {
            Button("Elimina", role: .destructive) {
                if let itemToDelete = selectedItem {
                    withAnimation {
                        context.delete(itemToDelete) // Elimina l'elemento dal contesto
                    }
                    selectedItem = nil // Resetta l'elemento selezionato
                }
            }
            Button("Annulla", role: .cancel) {
                selectedItem = nil // Resetta l'elemento selezionato
            }
        }, message: {
            Text("Sei sicuro di voler eliminare questo elemento?")
        })
    }
}

#Preview {
    ContentView()
}
