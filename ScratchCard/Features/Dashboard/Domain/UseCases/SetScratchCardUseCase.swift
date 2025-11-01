//
//  SetScratchCardUseCase.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

protocol SetScratchCardUseCase {
    func setScratchCard(_ card: ScratchCard) async
}

final class SetScratchCardUseCaseImp: SetScratchCardUseCase {
    private let repository: ScratchCardRepository

    init(repository: ScratchCardRepository) {
        self.repository = repository
    }

    func setScratchCard(_ card: ScratchCard) async {
        await repository.setScratchCard(card)
    }
}

