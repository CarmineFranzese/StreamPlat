//
//  StreamPlatApp.swift
//  StreamPlat
//
//  Created by Carmine Franzese on 10/12/24.
//

import SwiftUI
import SwiftData

@main
struct StreamPlatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: PlatformItems.self)
        }
    }
}
