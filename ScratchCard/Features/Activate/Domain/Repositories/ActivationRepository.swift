//
//  ActivationRepository.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

protocol ActivationRepository {
    func activateCard(code: String) async throws -> Double
}
