//
//  DashboardViewModel.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import Foundation

@Observable
final class DashboardViewModel {
    struct Dependencies {
        let getScratchCardUseCase: GetScratchCardUseCase
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    enum Action {
        case scratch
        case activate
    }

    enum State: Equatable {
        case loading
        case loaded(ScratchCard)
    }

    @MainActor private(set) var state: State = .loading

    private let parameters: Parameters
    private let dependencies: Dependencies

    @MainActor
    init(
        parameters: Parameters,
        dependencies: Dependencies
    ) {
        self.parameters = parameters
        self.dependencies = dependencies
    }

    @MainActor
    func onAppear() async {
        let card = await dependencies.getScratchCardUseCase()
        state = .loaded(card ?? ScratchCard(state: .unscratched))
    }

    @MainActor
    func onScratch() {
        parameters.onAction(.scratch)
    }

    @MainActor
    func onActivate() {
        parameters.onAction(.activate)
    }
}
