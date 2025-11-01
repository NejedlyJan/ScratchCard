//
//  GetScratchCardCodeUseCase.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

protocol GetScratchCardCodeUseCase {
    func callAsFunction() async throws -> String
}

final class GetScratchCardCodeUseCaseImp: GetScratchCardCodeUseCase {
    private let repository: GenerateScratchCardRepository

    init(repository: GenerateScratchCardRepository) {
        self.repository = repository
    }

    func callAsFunction() async throws -> String {
        try await repository.generate()
    }
}
