//
//  MockNetworkService.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

final class MockNetworkService: NetworkService {
    private let result: Result<RecipeResponse, NetworkError>

    init(mockData: Data) {
        do {
            let decoded = try JSONDecoder().decode(RecipeResponse.self, from: mockData)
            self.result = .success(decoded)
        } catch {
            self.result = .failure(.decodingFailed)
        }
    }

    init(failure: NetworkError) {
        self.result = .failure(failure)
    }

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        switch result {
        case .success(let response):
            return response as! T
        case .failure(let error):
            throw error
        }
    }
}
