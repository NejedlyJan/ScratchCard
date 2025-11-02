//
//  ScratchCardRepositoryMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class SetScratchCardUseCaseMock: SetScratchCardUseCase {
    private var scratchCard: ScratchCard?
    var setScratchCardCalled = 0

    init(scratchCard: ScratchCard? = nil) {
        self.scratchCard = scratchCard
    }

    func setScratchCard(_ card: ScratchCard) async {
        setScratchCardCalled += 1
        scratchCard = card
    }
}
