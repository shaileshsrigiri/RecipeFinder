//
//  RecipeViewModel.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    
    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkManager.shared) {
        self.networkService = networkService
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
}
