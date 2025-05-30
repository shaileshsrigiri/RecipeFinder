//
//  NetworkManager.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

final class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    private init() {}

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
