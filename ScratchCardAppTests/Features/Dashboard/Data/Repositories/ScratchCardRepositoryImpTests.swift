//
//  ScratchCardRepositoryImpTests.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class ScratchCardRepositoryImpTests: XCTestCase {
    func test_givenInitialState_whenGetScratchCard_thenReturnNil() async {
        let sut = makeSUT()

        let card = await sut.getScratchCard()

        XCTAssertNil(card)
    }

    func test_givenInitialState_whenSetScratchCard_thenCardNotNil() async throws {
        let givenCard = ScratchCard(state: .scratched(code: "test"))
        let sut = makeSUT()

        await sut.setScratchCard(givenCard)

        let retrievedCard = await sut.getScratchCard()

        guard case let .scratched(code) = retrievedCard?.state else {
            return XCTFail("Wrong state")
        }
        XCTAssertEqual(code, "test")
    }
}

extension ScratchCardRepositoryImpTests {
    private func makeSUT() -> ScratchCardRepositoryImp {
        ScratchCardRepositoryImp()
    }
}
