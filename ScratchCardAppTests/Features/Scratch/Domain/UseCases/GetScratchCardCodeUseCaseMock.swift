//
//  GetScratchCardCodeUseCase.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class GetScratchCardCodeUseCaseMock: GetScratchCardCodeUseCase {
    private var scratchCardCode: String

    init(scratchCardCode: String) {
        self.scratchCardCode = scratchCardCode
    }

    func callAsFunction() async throws -> String {
        scratchCardCode
    }
}

private enum TestError: Error {
    case mockError
}

final class FailingGetScratchCardCodeUseCaseMock: GetScratchCardCodeUseCase {
    func callAsFunction() async throws -> String {
        throw TestError.mockError
    }
}
