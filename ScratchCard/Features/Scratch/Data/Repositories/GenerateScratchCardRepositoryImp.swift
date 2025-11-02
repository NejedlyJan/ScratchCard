//
//  ScratchCardRepositoryImp.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

final class GenerateScratchCardRepositoryImp: GenerateScratchCardRepository {
    private let service: GenerateScratchCardService

    init(service: GenerateScratchCardService) {
        self.service = service
    }

    func generate() async throws -> String {
        try await service.generateCode()
    }
}

