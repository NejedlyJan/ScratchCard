//
//  ScratchViewModelTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class ScratchViewModelTests: XCTestCase {
    
    func test_whenInitialized_thenStateIsIdle() async {
        let sut = makeSUT()

        XCTAssertEqual(sut.state, .idle)
    }
    
    func test_givenSuccessfulCode_whenScratch_thenStateIsSuccess() async {
        let setScratchCardUseCaseMock = SetScratchCardUseCaseMock()
        let getScratchCardCodeUseCaseMock = GetScratchCardCodeUseCaseMock(scratchCardCode: "test")
        let sut = makeSUT(
            setScratchCardUseCase: setScratchCardUseCaseMock,
            getScratchCardCodeUseCase: getScratchCardCodeUseCaseMock
        )

        await sut.scratch()

        guard case let .success(code) = sut.state else {
            return XCTFail("Wrong state, should be .success")
        }

        XCTAssertEqual(setScratchCardUseCaseMock.setScratchCardCalled, 1)
        XCTAssertEqual(code, "test")
    }

    func test_givenFailingCode_whenScratch_thenStateIsIdle_andInvokeAction() async {
        var action: ScratchViewModel.Action?
        let getScratchCardCodeUseCaseMock = FailingGetScratchCardCodeUseCaseMock()
        let sut = makeSUT(getScratchCardCodeUseCase: getScratchCardCodeUseCaseMock) {
            action = $0
        }

        await sut.scratch()

        XCTAssertEqual(sut.state, .idle)
        XCTAssertEqual(action, .error)
    }
}

extension ScratchViewModelTests {
    private func makeSUT(
        setScratchCardUseCase: any SetScratchCardUseCase = SetScratchCardUseCaseMock(),
        getScratchCardCodeUseCase: any GetScratchCardCodeUseCase = GetScratchCardCodeUseCaseMock(scratchCardCode: ""),
        onAction: @MainActor @escaping (ScratchViewModel.Action) -> Void = { _ in }
    ) -> ScratchViewModel {
        ScratchViewModel(
            parameters: ScratchViewModel.Parameters(onAction: onAction),
            dependencies: ScratchViewModel.Dependencies(
                setScratchCardUseCase: setScratchCardUseCase,
                getScratchCardCodeUseCase: getScratchCardCodeUseCase
            )
        )
    }
}
