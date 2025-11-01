//
//  ScratchCardRepositoryMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class ScratchCardRepositoryMock: ScratchCardRepository {
    private var scratchCard: ScratchCard?
    var setScratchCardCalled = 0

    init(scratchCard: ScratchCard? = nil) {
        self.scratchCard = scratchCard
    }

    func getScratchCard() async -> ScratchCard? {
        scratchCard
    }
    
    func setScratchCard(_ card: ScratchCard) async {
        setScratchCardCalled += 1
        scratchCard = card
    }
}
