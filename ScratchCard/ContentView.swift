//
//  ContentView.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import SwiftUI

struct ContentView: View {
    let container: DependencyContainer

    var body: some View {
        container.makeDashboardFlow()
    }
}
