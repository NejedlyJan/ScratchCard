//
//  ScratchCardRepository.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

protocol ScratchCardRepository {
    func getScratchCard() async -> ScratchCard?
    func setScratchCard(_ card: ScratchCard) async
}
