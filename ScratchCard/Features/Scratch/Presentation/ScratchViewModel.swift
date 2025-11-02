import Combine
import Foundation

final class ScratchViewModel: ObservableObject {
    struct Dependencies {
        let setScratchCardUseCase: SetScratchCardUseCase
        let getScratchCardCodeUseCase: GetScratchCardCodeUseCase
    }

    struct Parameters {
        let onAction: (Action) -> Void
    }

    enum Action {
        case error
    }

    enum State {
        case idle
        case scratching
        case success(code: String)
    }

    @MainActor @Published private(set) var state: State = .idle

    private let parameters: Parameters
    private let dependencies: Dependencies

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
