//
//  GetScratchCardUseCaseImpTests.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class GetScratchCardUseCaseImpTests: XCTestCase {
    func test_givenRepositoryReturnsNil_whenCallAsFunction_thenReturnNil() async {
        let repositoryMock = ScratchCardRepositoryMock(scratchCard: nil)
        let sut = makeSUT(repository: repositoryMock)

        let card = await sut()

        XCTAssertNil(card)
    }

    func test_givenRepositoryReturnsCard_whenCallAsFunction_thenReturnCard() async {
        let repositoryMock = ScratchCardRepositoryMock(scratchCard: ScratchCard(state: .activated))
        let sut = makeSUT(repository: repositoryMock)

        let card = await sut()

        XCTAssertNotNil(card)
        guard case let .scratched(code) = card?.state else {
            return XCTFail("Wrong state")
        }
        XCTAssertEqual(code, "test")
    }
}

extension GetScratchCardUseCaseImpTests {
    private func makeSUT(
        repository: any ScratchCardRepository = ScratchCardRepositoryMock()
    ) -> GetScratchCardUseCaseImp {
        GetScratchCardUseCaseImp(repository: repository)
    }
}
