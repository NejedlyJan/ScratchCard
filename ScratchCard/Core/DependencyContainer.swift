//
//  DependencyContainer.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

final class DependencyContainer {
    // MARK: - Services
    private lazy var generateScratchCardService: GenerateScratchCardService = {
        GenerateScratchCardServiceImp()
    }()

    // MARK: - Repositories
    private lazy var scratchCardRepository: ScratchCardRepository = {
        ScratchCardRepositoryImp()
    }()

    private lazy var generateScratchCardRepository: GenerateScratchCardRepository = {
        GenerateScratchCardRepositoryImp(service: generateScratchCardService)
    }()

    // MARK: - Flows
    func makeDashboardFlow() -> DashboardFlow {
        DashboardFlow(
            dependencies: DashboardFlow.Dependencies(
                dashboardView: makeDashboardView,
                scratchFlow: makeScratchFlow
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

    // MARK: - Views
    @MainActor
    private func makeDashboardView(parameters: DashboardViewModel.Parameters) -> DashboardView {
        let getScratchCardUseCase = GetScratchCardUseCaseImp(repository: scratchCardRepository)

        let viewModel = DashboardViewModel(
            parameters: parameters,
            dependencies: DashboardViewModel.Dependencies(
                getScratchCardUseCase: getScratchCardUseCase
            )
        )
        return DashboardView(viewModel: viewModel)
    }

    @MainActor
    private func makeScratchView(parameters: ScratchViewModel.Parameters) -> ScratchView {
        let setScratchCardUseCase = SetScratchCardUseCaseImp(repository: scratchCardRepository)
        let getScratchCardCodeUseCase = GetScratchCardCodeUseCaseImp(repository: generateScratchCardRepository)

        let viewModel = ScratchViewModel(
            parameters: parameters,
            dependencies: ScratchViewModel.Dependencies(
                setScratchCardUseCase: setScratchCardUseCase,
                getScratchCardCodeUseCase: getScratchCardCodeUseCase
            )
        )
        return ScratchView(viewModel: viewModel)
    }
}
