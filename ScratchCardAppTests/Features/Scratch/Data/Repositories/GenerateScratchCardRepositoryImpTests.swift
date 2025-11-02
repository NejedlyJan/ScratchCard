//
//  GenerateScratchCardRepositoryImpTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class GenerateScratchCardRepositoryImpTests: XCTestCase {
    func test_whenGenerate_thenReturnScratchCardCode() async throws {
        let generateScratchCardServiceMock = GenerateScratchCardServiceMock(code: "test")
        let sut = makeSUT(service: generateScratchCardServiceMock)

        let card = try await sut.generate()

        XCTAssertEqual(card, "test")
    }
}

extension GenerateScratchCardRepositoryImpTests {
    private func makeSUT(
        service: any GenerateScratchCardService = GenerateScratchCardServiceMock(code: "")
    ) -> GenerateScratchCardRepositoryImp {
        GenerateScratchCardRepositoryImp(service: service)
    }
}
