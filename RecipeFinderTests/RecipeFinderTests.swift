//
//  RecipeFinderTests.swift
//  RecipeFinderTests
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import XCTest
@testable import RecipeFinder


final class RecipeFinderTests: XCTestCase {
    
    func testValidMockJSON_shouldLoadRecipes() async {
        let mockService = MockNetworkService(mockData: MockJSON.valid)
        let viewModel = await RecipeViewModel(networkService: mockService)

        await viewModel.loadRecipes()

        await MainActor.run {
            XCTAssertEqual(viewModel.recipes.count, 1)
            XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik")
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testMalformedJSON_shouldSetError() async {
        let mockService = MockNetworkService(mockData: MockJSON.malformed)
        let viewModel = await RecipeViewModel(networkService: mockService)

        await viewModel.loadRecipes()

        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "Failed to load recipes. Please try again.")

        }
    }

    func testEmptyJSON_shouldShowNoRecipes() async {
        let mockService = MockNetworkService(mockData: MockJSON.empty)
        let viewModel = await RecipeViewModel(networkService: mockService)

        await viewModel.loadRecipes()

        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
        }
    }
    

}



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

// MARK: - Sample JSON Data

enum MockJSON {
    static let valid: Data = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://example.com/large.jpg",
                "photo_url_small": "https://example.com/small.jpg",
                "source_url": "https://example.com/source",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://youtube.com/example"
            }
        ]
    }
    """.data(using: .utf8)!

    
    static let malformed: Data = """
    {
        "recipes": [
            {
                "cuisine": "British"
            }
        ]
    }
    """.data(using: .utf8)!

    
    static let empty: Data = """
    {
        "recipes": []
    }
    """.data(using: .utf8)!
}
