//
//  RecipeViewModelTests.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//


import XCTest
@testable import RecipeFinder

final class RecipeViewModelTests: XCTestCase {

    func testLoadRecipes_success_shouldUpdateRecipes() async {
        // Arrange
        let mockService = MockNetworkService(mockData: MockJSON.valid)
        let viewModel = await RecipeViewModel(networkService: mockService)

        // Act
        await viewModel.loadRecipes()

        // Assert
        await MainActor.run {
            XCTAssertEqual(viewModel.recipes.count, 1)
            XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik")
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testLoadRecipes_failure_shouldSetErrorMessage() async {
        // Arrange
        let mockService = MockNetworkService(mockData: MockJSON.malformed)
        let viewModel = await RecipeViewModel(networkService: mockService)

        // Act
        await viewModel.loadRecipes()

        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertEqual(viewModel.errorMessage, "Failed to load recipes. Please try again.")
        }
    }

    func testLoadRecipes_emptyList_shouldShowNoRecipesAndNoError() async {
        // Arrange
        let mockService = MockNetworkService(mockData: MockJSON.empty)
        let viewModel = await RecipeViewModel(networkService: mockService)

        // Act
        await viewModel.loadRecipes()

        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
        }
    }
}
