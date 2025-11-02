//
//  ActivationService.swift
//  ScratchCard
//
//  Created by Jan Nejedlý on 02.11.2025.
//

import Foundation

struct ActivationResponse: Codable {
    let ios: String
}

protocol ActivationService {
    func activate(code: String) async throws -> Double
}

final class ActivationServiceImp: ActivationService {
    func activate(code: String) async throws -> Double {
        guard var components = URLComponents(string: "https://api.o2.sk/version") else {
            throw ActivationError.invalidURL
        }

        components.queryItems = [URLQueryItem(name: "code", value: code)]

        guard let url = components.url else {
            throw ActivationError.invalidURL
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let response = try? JSONDecoder().decode(ActivationResponse.self, from: data) else {
            throw ActivationError.invalidResponse
        }

        guard let version = Double(response.ios) else {
            throw ActivationError.invalidResponse
        }

        return 6
    }
}

