//
//  GetScratchCardUseCaseMock.swift
//  ScratchCardAppTests
//
//  Created by Jan Nejedlý on 01.11.2025.
//

@testable import ScratchCard

final class GetScratchCardUseCaseMock: GetScratchCardUseCase {
    private var scratchCard: ScratchCard?

    init(scratchCard: ScratchCard? = nil) {
        self.scratchCard = scratchCard
    }

    func callAsFunction() async -> ScratchCard? {
        scratchCard
    }
}
