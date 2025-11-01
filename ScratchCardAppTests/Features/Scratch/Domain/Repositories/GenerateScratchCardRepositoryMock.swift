//
//  ScratchCardRepositoryMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class GenerateScratchCardRepositoryMock: GenerateScratchCardRepository {
    private var code: String

    init(code: String) {
        self.code = code
    }

    func generate() async throws -> String {
        code
    }
}
