//
//  ActivateCardUseCaseMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

@testable import ScratchCard

final class ActivateCardUseCaseMock: ActivateCardUseCase {
    private var version: Double

    init(version: Double) {
        self.version = version
    }

    func activateCard(code: String) async throws -> Double {
        version
    }
}

final class FailingActivateCardUseCaseMock: ActivateCardUseCase {
    func activateCard(code: String) async throws -> Double {
        throw ActivationError.invalidURL
    }
}
