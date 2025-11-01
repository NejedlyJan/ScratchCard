//
//  ScratchCardService.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

import Foundation

protocol GenerateScratchCardService: Sendable {
    func generateCode() async throws -> String
}

final class GenerateScratchCardServiceImp: GenerateScratchCardService {
    func generateCode() async throws -> String {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return UUID().uuidString
    }
}
