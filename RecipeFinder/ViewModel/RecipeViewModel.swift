//
//  RecipeViewModel.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

@MainActor
final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    @Published var searchText: String = ""

    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkManager.shared) {
        self.networkService = networkService
    }
    
    var uniqueCuisines: [String] {
        Set(recipes.map { $0.cuisine }).sorted()
    }

    func recipesForCuisine(_ cuisine: String) -> [Recipe] {
        recipes.filter { $0.cuisine == cuisine }
    }

    func representativeImage(for cuisine: String) -> URL? {
        recipes.first(where: { $0.cuisine == cuisine })?.photoURL
    }

    func loadRecipes() async {
        do {
            let response: RecipeResponse = try await networkService.fetch(from: APIEndpoint.recipes)
            self.recipes = response.recipes
            self.errorMessage = nil
        } catch {
            self.recipes = []
            self.errorMessage = "Failed to load recipes. Please try again."
        }
    }

    var filteredRecipes: [Recipe] {
        searchText.isEmpty
            ? recipes
            : recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.cuisine.localizedCaseInsensitiveContains(searchText)
            }
    }
}


