//
//  ScratchCardApp.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import SwiftUI

@main
struct ScratchCardApp: App {
    let container = DependencyContainer.shared

    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}
