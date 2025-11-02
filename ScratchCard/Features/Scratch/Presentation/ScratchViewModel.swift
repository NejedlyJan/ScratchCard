import Foundation

@Observable
final class ScratchViewModel {
    struct Dependencies {
        let setScratchCardUseCase: SetScratchCardUseCase
        let getScratchCardCodeUseCase: GetScratchCardCodeUseCase
    }

    struct Parameters {
        let onAction: @MainActor (Action) -> Void
    }

    enum Action {
        case error
    }

    enum State: Equatable {
        case idle
        case scratching
        case success(code: String)
    }

    @MainActor private(set) var state: State = .idle

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

    func scratch() async {
        guard case .idle = state else { return }

        state = .scratching

        do {
            let code = try await dependencies.getScratchCardCodeUseCase()

            let card = ScratchCard(state: .scratched(code: code))
            await dependencies.setScratchCardUseCase.setScratchCard(card)

            state = .success(code: code)
        } catch {
            state = .idle
            parameters.onAction(.error)
        }
    }
}
