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
        
        guard case .idle = sut.state else {
            return XCTFail("Wrong state, should be .idle")
        }
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

        guard case .idle = sut.state else {
            return XCTFail("Wrong state, should be .idle")
        }

        guard case .error = action else {
            return XCTFail("Wrong action, should be .error")
        }
    }
}

extension ScratchViewModelTests {
    private func makeSUT(
        setScratchCardUseCase: some SetScratchCardUseCase = SetScratchCardUseCaseMock(),
        getScratchCardCodeUseCase: some GetScratchCardCodeUseCase = GetScratchCardCodeUseCaseMock(scratchCardCode: ""),
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
