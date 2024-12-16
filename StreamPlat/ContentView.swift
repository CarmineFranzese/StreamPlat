//
//  ContentView.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 10/12/24.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    
    @Environment(\.modelContext) var context
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showSettings = false
    @State private var showCreate = false
    @State private var PlatformEdit: PlatformItems?
    @State private var showDeleteConfirmation = false
    @State private var selectedItem: PlatformItems?
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
                                    .fill(isDarkMode ? Color.green : Color.gray)
                                    .frame(height: 100)
                                    .accessibilityLabel("\(item.title), \(item.info), \(Calendar.current.dateComponents([.day], from: Date(), to: item.date).day ?? 0) days left")
                                
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
                                PlatformEdit = item
                            }
                            .onLongPressGesture {
                                selectedItem = item
                                showDeleteConfirmation = true
                            }
                        }
                    }
                    .padding()
                    .searchable(text: $searchQuery, prompt: "Search")
                    .accessibilityLabel("Search field")
                    Text("My Lists")
                        .font(.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .accessibilityLabel("My Lists")
                    ForEach(items) { item in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isDarkMode ? Color.green : Color.gray)
                                .accessibilityLabel("\(item.title)")
                            HStack {
                                Text(item.title)
                                    .font(.system(size: 25))
                                    .bold()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 0))
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 6, trailing: 20))
                        .onTapGesture {
                        }
                        .onLongPressGesture {
                            selectedItem = item
                            showDeleteConfirmation = true
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
                    .accessibilityLabel("Add Item")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSettings = true
                    }, label: {
                        Image(systemName: "gearshape.fill")
                    })
                    .accessibilityLabel("Settings")
                }
            }
        }
        .sheet(isPresented: $showCreate) {
            NavigationStack {
                Create1View()
                    .presentationDetents([.medium])
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView(isDarkMode: $isDarkMode)
                .presentationDetents([.medium])
        }
        .sheet(item: $PlatformEdit) {
            PlatformEdit = nil
        } content: { item in
            UpdateView(item: item)
                .presentationDetents([.medium])
        }
        .alert("Confirm Delete", isPresented: $showDeleteConfirmation, actions: {
            Button("Delete", role: .destructive) {
                if let itemToDelete = selectedItem {
                    withAnimation {
                        context.delete(itemToDelete)
                    }
                    selectedItem = nil
                }
            }
            Button("Cancel", role: .cancel) {
                selectedItem = nil
            }
        }, message: {
            Text("Are you sure you want to delete?")
        })
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
