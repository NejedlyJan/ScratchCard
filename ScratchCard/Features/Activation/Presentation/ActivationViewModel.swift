//
//  ActivationViewModel.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import Foundation

@Observable
final class ActivationViewModel {
    struct Dependencies {
        let getScratchCardUseCase: GetScratchCardUseCase
        let setScratchCardUseCase: SetScratchCardUseCase
        let activateCardUseCase: ActivateCardUseCase
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    enum Action {
        case error
    }

    enum State {
        case unscratched
        case scratched
        case activating
        case activated
    }

    @MainActor private(set) var state: State = .unscratched
    private var code: String?

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

    func onAppear() async {
        switch await dependencies.getScratchCardUseCase()?.state {
        case .unscratched, .none:
            state = .unscratched
        case let .scratched(code):
            self.code = code
            state = .scratched
        case .activated:
            state = .activated
        }
    }

    func activate() async {
        guard case .scratched = state, let code else {
            return
        }

        state = .activating

        do {
            let version = try await dependencies.activateCardUseCase.activateCard(code: code)

            if isVersionValid(version) {
                let activatedCard = ScratchCard(state: .activated)
                await dependencies.setScratchCardUseCase.setScratchCard(activatedCard)
                state = .activated
            } else {
                handleError()
            }
        } catch {
            handleError()
        }
    }

    private func handleError() {
        state = .scratched
        parameters.onAction(.error)
    }

    private func isVersionValid(_ version: Double) -> Bool {
        version > 6.1
    }
}
