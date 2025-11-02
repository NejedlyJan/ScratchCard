//
//  ActivationServiceMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 02.11.2025.
//

@testable import ScratchCard

final class ActivationServiceMock: ActivationService {
    let version: Double

    init(version: Double) {
        self.version = version
    }

    func activate(code: String) async throws -> Double {
        version
    }
}

final class FailingActivationServiceMock: ActivationService {
    func activate(code: String) async throws -> Double {
        throw ActivationError.invalidURL
    }
}
