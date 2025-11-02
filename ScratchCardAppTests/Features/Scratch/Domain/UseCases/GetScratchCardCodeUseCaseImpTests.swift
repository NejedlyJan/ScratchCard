//
//  GetScratchCardUseCaseImpTests.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class GetScratchCardCodeUseCaseImpTests: XCTestCase {
    func test_givenRepositoryReturnsNil_whenCallAsFunction_thenReturnNil() async throws {
        let repositoryMock = GenerateScratchCardRepositoryMock(code: "test")
        let sut = makeSUT(repository: repositoryMock)

        let code = try await sut()

        XCTAssertEqual(code, "test")
    }
}

extension GetScratchCardCodeUseCaseImpTests {
    private func makeSUT(
        repository: any GenerateScratchCardRepository = GenerateScratchCardRepositoryMock(code: "")
    ) -> GetScratchCardCodeUseCaseImp {
        GetScratchCardCodeUseCaseImp(repository: repository)
    }
}
