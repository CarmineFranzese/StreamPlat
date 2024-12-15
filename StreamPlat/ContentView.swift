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
    @State private var PlatformEdit: PlatformItems?
    @State private var showDeleteConfirmation = false
    @State private var selectedItem: PlatformItems? // L'elemento attualmente selezionato per la cancellazione
    @Query private var items: [PlatformItems]
    
    @State private var searchQuery = ""
    
    var filteredItems: [PlatformItems] {
        
        if searchQuery.isEmpty {
            return items
        }
        
        let filteredItems = items.compactMap { item in
            let titleContainsQuery = item.title.range(of: searchQuery, options: .caseInsensitive) != nil
            return titleContainsQuery ? item : nil
        }
        
        return filteredItems
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]) {
                        ForEach(filteredItems) { item in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray)
                                    .frame(height: 100)
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.system(size: 25))
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(item.info)
                                        .font(.system(size: 13))
                                    if let daysRemaining = Calendar.current.dateComponents([.day], from: Date(), to: item.date).day {
                                        Text("\(daysRemaining) Days left")
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .bold()
                                            .font(.system(size: 13))
                                    }
                                }
                                .padding()
                            }
                            .onTapGesture {
                                PlatformEdit = item // Apri direttamente la sheet di modifica
                            }
                            .onLongPressGesture {
                                selectedItem = item // Imposta l'elemento selezionato
                                showDeleteConfirmation = true // Mostra la finestra di conferma
                            }
                        }
                    }
                    .padding()
                    .searchable(text: $searchQuery, prompt: "Search")
                    Text("My Lists")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    ForEach(items) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray)
                            HStack() {
                                Text(item.title)
                                    .font(.system(size: 25))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                        .onTapGesture {
                            //PlatformEdit = item // Apri direttamente la sheet di modifica
                        }
                        .onLongPressGesture {
                            selectedItem = item // Imposta l'elemento selezionato
                            showDeleteConfirmation = true // Mostra la finestra di conferma
                        }
                    }
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
        .sheet(item: $PlatformEdit) {
            PlatformEdit = nil
        } content: { item in
            UpdateView(item: item)
        }
        .alert("Confirm Delete", isPresented: $showDeleteConfirmation, actions: {
            Button("Delete", role: .destructive) {
                if let itemToDelete = selectedItem {
                    withAnimation {
                        context.delete(itemToDelete) // Elimina l'elemento dal contesto
                    }
                    selectedItem = nil // Resetta l'elemento selezionato
                }
            }
            Button("Cancel", role: .cancel) {
                selectedItem = nil // Resetta l'elemento selezionato
            }
        }, message: {
            Text("Are you sure you want to delete?")
        })
    }
}

#Preview {
    ContentView()
}
