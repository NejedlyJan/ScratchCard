//
//  SetScratchCardUseCaseImpTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class SetScratchCardUseCaseImpTests: XCTestCase {
    let repositoryMock = ScratchCardRepositoryMock()
    func test_givenRepositoryReturnsNil_whenCallAsFunction_thenReturnNil() async {
        let sut = makeSUT(repository: repositoryMock)

        await sut.setScratchCard(ScratchCard(state: .activated))

        XCTAssertEqual(repositoryMock.setScratchCardCalled, 1)
    }
}

extension SetScratchCardUseCaseImpTests {
    private func makeSUT(
        repository: some ScratchCardRepository = ScratchCardRepositoryMock()
    ) -> SetScratchCardUseCaseImp {
        SetScratchCardUseCaseImp(repository: repository)
    }
}
