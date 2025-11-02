//
//  DependencyContainer.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

final class DependencyContainer {
    static let shared = DependencyContainer()
    
    private init() {}
    // MARK: - Services
    private lazy var generateScratchCardService: GenerateScratchCardService = {
        GenerateScratchCardServiceImp()
    }()

    private lazy var activationService: ActivationService = {
        ActivationServiceImp()
    }()

    // MARK: - Repositories
    private lazy var scratchCardRepository: ScratchCardRepository = {
        ScratchCardRepositoryImp()
    }()

    private lazy var generateScratchCardRepository: GenerateScratchCardRepository = {
        GenerateScratchCardRepositoryImp(service: generateScratchCardService)
    }()

    private lazy var activationRepository: ActivationRepository = {
        ActivationRepositoryImp(service: activationService)
    }()

    // MARK: - Use Case
    private func makeGetScratchCardUseCase() -> GetScratchCardUseCase {
        GetScratchCardUseCaseImp(repository: scratchCardRepository)
    }

    private func makeSetScratchCardUseCase() -> SetScratchCardUseCase {
        SetScratchCardUseCaseImp(repository: scratchCardRepository)
    }

    private func makeGetScratchCardCodeUseCase() -> GetScratchCardCodeUseCase {
        GetScratchCardCodeUseCaseImp(repository: generateScratchCardRepository)
    }

    private func makeActivateCardUseCase() -> ActivateCardUseCase {
        ActivateCardUseCaseImp(repository: activationRepository)
    }

    // MARK: - Flows
    func makeDashboardFlow() -> DashboardFlow {
        DashboardFlow(
            dependencies: DashboardFlow.Dependencies(
                dashboardView: makeDashboardView,
                scratchFlow: makeScratchFlow,
                activationFlow: makeActivationFlow
            )
        )
    }

    func makeScratchFlow() -> ScratchFlow {
        ScratchFlow(
            dependencies: ScratchFlow.Dependencies(
                scratchView: makeScratchView
            )
        )
    }

    func makeActivationFlow() -> ActivationFlow {
        ActivationFlow(
            dependencies: ActivationFlow.Dependencies(
                activationView: makeActivationView
            )
        )
    }

    // MARK: - Views
    @MainActor
    private func makeDashboardView(parameters: DashboardViewModel.Parameters) -> DashboardView {
        let viewModel = DashboardViewModel(
            parameters: parameters,
            dependencies: DashboardViewModel.Dependencies(
                getScratchCardUseCase: makeGetScratchCardUseCase()
            )
        )
        return DashboardView(viewModel: viewModel)
    }

    @MainActor
    private func makeScratchView(parameters: ScratchViewModel.Parameters) -> ScratchView {
        let viewModel = ScratchViewModel(
            parameters: parameters,
            dependencies: ScratchViewModel.Dependencies(
                setScratchCardUseCase: makeSetScratchCardUseCase(),
                getScratchCardCodeUseCase: makeGetScratchCardCodeUseCase()
            )
        )
        return ScratchView(viewModel: viewModel)
    }

    @MainActor
    private func makeActivationView(parameters: ActivationViewModel.Parameters) -> ActivationView {
        let viewModel = ActivationViewModel(
            parameters: parameters,
            dependencies: ActivationViewModel.Dependencies(
                getScratchCardUseCase: makeGetScratchCardUseCase(),
                setScratchCardUseCase: makeSetScratchCardUseCase(),
                activateCardUseCase: makeActivateCardUseCase()
            )
        )
        return ActivationView(viewModel: viewModel)
    }
}
