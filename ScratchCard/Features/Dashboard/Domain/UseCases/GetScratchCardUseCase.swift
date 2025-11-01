//
//  GetScratchCardUseCase.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

protocol GetScratchCardUseCase {
    func callAsFunction() async -> ScratchCard?
}

final class GetScratchCardUseCaseImp: GetScratchCardUseCase {
    private let repository: ScratchCardRepository

    init(repository: ScratchCardRepository) {
        self.repository = repository
    }

    func callAsFunction() async -> ScratchCard? {
        await repository.getScratchCard()
    }
}
