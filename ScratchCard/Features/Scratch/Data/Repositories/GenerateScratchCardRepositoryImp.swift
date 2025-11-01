//
//  ScratchCardRepositoryImp.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 01.11.2025.
//

actor GenerateScratchCardRepositoryImp: GenerateScratchCardRepository {
    private let service: GenerateScratchCardService

    init(service: GenerateScratchCardService) {
        self.service = service
    }

    func generate() async throws -> String {
        try await service.generateCode()
    }
}

