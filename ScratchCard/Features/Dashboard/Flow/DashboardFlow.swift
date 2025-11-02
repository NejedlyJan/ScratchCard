//
//  ScratchFlow.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import SwiftUI

struct DashboardFlow: View {
    struct Dependencies {
        let dashboardView: (DashboardViewModel.Parameters) -> DashboardView
        let scratchFlow: () -> ScratchFlow
    }

    enum Destination: Hashable {
        case scratch
    }

    let dependencies: Dependencies

    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navigationPath) {
            dependencies.dashboardView(
                DashboardViewModel.Parameters(
                    onAction: { onAction in
                        switch onAction {
                        case .scratch:
                            navigationPath.append(Destination.scratch)
                        case .activate: break
                        }
                    }
                )
            )
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .scratch:
                    dependencies.scratchFlow()
                }
            }
        }
    }
}

