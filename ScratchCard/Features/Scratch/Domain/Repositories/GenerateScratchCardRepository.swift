//
//  ScratchCardRepository.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

protocol GenerateScratchCardRepository {
    func generate() async throws -> String
}
