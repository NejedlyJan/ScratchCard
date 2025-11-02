//
//  ActivateCardUseCaseImpTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class ActivateCardUseCaseImpTests: XCTestCase {
    func test__whenCallAsFunction_thenReturnNil() async throws {
        let repositoryMock = ActivationRepositoryMock(version: 10)
        let sut = makeSUT(repository: repositoryMock)

        let version = try await sut.activateCard(code: "")

        XCTAssertEqual(version, 10)
    }

    func test_givenFailingRepository_whenActivateCard_thenRethrowError() async throws {
        let repositoryMock = FailingActivationRepositoryMock()
        let sut = makeSUT(repository: repositoryMock)

        do {
            _ = try await sut.activateCard(code: "code")
            XCTFail("Expected error to be thrown")
        } catch let error as ActivationError {
            XCTAssertEqual(error, .invalidURL)
        } catch {
            XCTFail("Expected ActivationError but got \(error)")
        }
    }
}

extension ActivateCardUseCaseImpTests {
    private func makeSUT(
        repository: some ActivationRepository = ActivationRepositoryMock(version: 0)
    ) -> ActivateCardUseCaseImp {
        ActivateCardUseCaseImp(repository: repository)
    }
}

