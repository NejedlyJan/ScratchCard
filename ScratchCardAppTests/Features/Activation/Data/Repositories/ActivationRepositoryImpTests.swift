//
//  ActivationRepositoryImpTests.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import XCTest
@testable import ScratchCard

@MainActor
final class ActivationRepositoryImpTests: XCTestCase {
    func test_whenActivateCard_thenReturnVersion() async throws {
        let activationServiceMock = ActivationServiceMock(version: 10)
        let sut = makeSUT(service: activationServiceMock)

        let version = try await sut.activateCard(code: "code")

        XCTAssertEqual(version, 10)
    }

    func test_givenFailingService_whenActivateCard_thenRethrowError() async throws {
        let activationServiceMock = FailingActivationServiceMock()
        let sut = makeSUT(service: activationServiceMock)

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

extension ActivationRepositoryImpTests {
    private func makeSUT(
        service: any ActivationService = ActivationServiceMock(version: 0)
    ) -> ActivationRepositoryImp {
        ActivationRepositoryImp(service: service)
    }
}
