//
//  ActivationRepositoryImp.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

final class ActivationRepositoryImp: ActivationRepository {
    private let service: ActivationService

    init(service: ActivationService) {
        self.service = service
    }

    func activateCard(code: String) async throws -> Double {
        try await service.activate(code: code)
    }
}

