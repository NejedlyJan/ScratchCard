//
//  ActivateCardUseCase.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

protocol ActivateCardUseCase {
    func activateCard(code: String) async throws -> Double
}

final class ActivateCardUseCaseImp: ActivateCardUseCase {
    private let repository: ActivationRepository

    init(repository: ActivationRepository) {
        self.repository = repository
    }

    func activateCard(code: String) async throws -> Double {
        try await repository.activateCard(code: code)
    }
}
