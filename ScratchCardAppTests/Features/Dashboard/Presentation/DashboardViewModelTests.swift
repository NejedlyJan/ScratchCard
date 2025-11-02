//
//  DashboardViewModelTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class DashboardViewModelTests: XCTestCase {

    func test_whenInitialized_thenStateIsLoading() async {
        let sut = makeSUT()

        guard case .loading = sut.state else {
            return XCTFail("Wrong state, should be .loading")
        }
    }

    func test_givenNilScratchCard_whenOnAppear_thenStateIsLoaded_andUnscratched() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: nil)
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        guard case let .loaded(card) = sut.state else {
            return XCTFail("Wrong state, should be .loaded")
        }

        XCTAssertEqual(card.state, .unscratched)
    }

    func test_givenScratchedScratchCard_whenOnAppear_thenStateIsLoaded_andScratched() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .scratched(code: "test")))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        guard case let .loaded(card) = sut.state else {
            return XCTFail("Wrong state, should be .loaded")
        }

        guard case let .scratched(code) = card.state else {
            return XCTFail("Wrong state, should be .scratched")
        }

        XCTAssertEqual(code, "test")
    }

    func test_givenActivatedScratchCard_whenOnAppear_thenStateIsLoaded_andActivated() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .activated))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        guard case let .loaded(card) = sut.state else {
            return XCTFail("Wrong state, should be .loaded")
        }

        XCTAssertEqual(card.state, .activated)
    }

    func test_whenOnScratch_theInvokeAction() async {
        var action: DashboardViewModel.Action?
        let sut = makeSUT() {
            action = $0
        }

        sut.onScratch()

        guard case .scratch = action else {
            return XCTFail("Wrong action, should be .scratch")
        }
    }

    func test_whenOnActivate_theInvokeAction() async {
        var action: DashboardViewModel.Action?
        let sut = makeSUT() {
            action = $0
        }

        sut.onActivate()

        guard case .activate = action else {
            return XCTFail("Wrong action, should be .activate")
        }
    }
}

extension DashboardViewModelTests {
    private func makeSUT(
        getScratchCardUseCase: some GetScratchCardUseCase = GetScratchCardUseCaseMock(),
        onAction: @MainActor @escaping (DashboardViewModel.Action) -> Void = { _ in }
    ) -> DashboardViewModel {
        DashboardViewModel(
            parameters: DashboardViewModel.Parameters(onAction: onAction),
            dependencies: DashboardViewModel.Dependencies(
                getScratchCardUseCase: getScratchCardUseCase
            )
        )
    }
}

