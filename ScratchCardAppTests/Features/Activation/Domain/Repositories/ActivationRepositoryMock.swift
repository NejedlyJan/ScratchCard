//
//  ActivationRepositoryMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

@testable import ScratchCard

final class ActivationRepositoryMock: ActivationRepository {
    private var version: Double

    init(version: Double) {
        self.version = version
    }

    func activateCard(code: String) async throws -> Double {
        version
    }
}

final class FailingActivationRepositoryMock: ActivationRepository {
    func activateCard(code: String) async throws -> Double {
        throw ActivationError.invalidURL
    }
}
