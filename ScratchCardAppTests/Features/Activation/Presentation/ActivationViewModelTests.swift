//
//  ActivationViewModelTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class ActivationViewModelTests: XCTestCase {

    func test_whenInitialized_thenStateIsUnscratched() async {
        let sut = makeSUT()

        XCTAssertEqual(sut.state, .unscratched)
    }

    func test_givenNilScratchCard_whenOnAppear_thenStateUnscratched() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: nil)
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        XCTAssertEqual(sut.state, .unscratched)
    }

    func test_givenUnscratchedScratchCard_whenOnAppear_thenStateUnscratched() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .unscratched))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        XCTAssertEqual(sut.state, .unscratched)
    }

    func test_givenScratchedScratchCard_whenOnAppear_thenStateUnscratched() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .scratched(code: "test")))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        XCTAssertEqual(sut.state, .scratched)
    }

    func test_givenActivatedScratchCard_whenOnAppear_thenStateActivated() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .activated))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.onAppear()

        XCTAssertEqual(sut.state, .activated)
    }

    func test_givenUnscratchedScratchCard_whenActivate_thenStateNotActivating() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .unscratched))
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock
        )

        await sut.activate()

        XCTAssertNotEqual(sut.state, .activating)
    }

    func test_givenSuccessfulActivation_whenActivate_thenStateActivated() async {
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .scratched(code: "test")))
        let activateCardUseCaseMock = ActivateCardUseCaseMock(version: 7)
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock,
            activateCardUseCase: activateCardUseCaseMock
        )
        await sut.onAppear()

        await sut.activate()

        XCTAssertEqual(sut.state, .activated)
    }

    func test_givenFailingActivation_whenActivate_thenInvokeAction() async {
        var action: ActivationViewModel.Action?
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .scratched(code: "test")))
        let activateCardUseCaseMock = FailingActivateCardUseCaseMock()
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock,
            activateCardUseCase: activateCardUseCaseMock
        ) {
            action = $0
        }
        await sut.onAppear()

        await sut.activate()

        XCTAssertEqual(action, .error)
    }

    func test_givenVersionTooLow_whenActivate_thenInvokeAction() async {
        var action: ActivationViewModel.Action?
        let getScratchCardUseCaseMock = GetScratchCardUseCaseMock(scratchCard: ScratchCard(state: .scratched(code: "test")))
        let activateCardUseCaseMock = ActivateCardUseCaseMock(version: 1)
        let sut = makeSUT(
            getScratchCardUseCase: getScratchCardUseCaseMock,
            activateCardUseCase: activateCardUseCaseMock
        ) {
            action = $0
        }
        await sut.onAppear()

        await sut.activate()

        XCTAssertEqual(action, .error)
    }
}

extension ActivationViewModelTests {
    private func makeSUT(
        getScratchCardUseCase: some GetScratchCardUseCase = GetScratchCardUseCaseMock(),
        setScratchCardUseCase: some SetScratchCardUseCase = SetScratchCardUseCaseMock(),
        activateCardUseCase: some ActivateCardUseCase = ActivateCardUseCaseMock(version: 0),
        onAction: @MainActor @escaping (ActivationViewModel.Action) -> Void = { _ in }
    ) -> ActivationViewModel {
        ActivationViewModel(
            parameters: ActivationViewModel.Parameters(onAction: onAction),
            dependencies: ActivationViewModel.Dependencies(
                getScratchCardUseCase: getScratchCardUseCase,
                setScratchCardUseCase: setScratchCardUseCase,
                activateCardUseCase: activateCardUseCase
            )
        )
    }
}

