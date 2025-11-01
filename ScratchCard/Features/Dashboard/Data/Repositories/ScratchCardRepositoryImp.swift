//
//  ScratchCardRepositoryImp.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

actor ScratchCardRepositoryImp: ScratchCardRepository {
    private var scratchCard: ScratchCard?

    func getScratchCard() async -> ScratchCard? {
        scratchCard
    }

    func setScratchCard(_ card: ScratchCard) async {
        scratchCard = card
    }
}

