//
//  ScratchCardServiceMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class GenerateScratchCardServiceMock: GenerateScratchCardService {
    let code: String

    init(code: String) {
        self.code = code
    }

    func generateCode() async throws -> String {
        code
    }
}
