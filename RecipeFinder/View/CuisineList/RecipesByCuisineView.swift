//
//  RecipesByCuisineView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import SwiftUI

struct RecipesByCuisineView: View {
    let cuisine: String
    let recipes: [Recipe]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading, spacing: 8) {
                            AsyncImageView(url: recipe.photoURL)
                                .frame(height: 140)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(12)
                                .clipped()

                            Text(recipe.name)
                                .font(.headline)
                                .lineLimit(1)
                                .foregroundColor(.primary)

                            Text(recipe.cuisine)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(cuisine)
    }
}


#Preview {
    let decoder = JSONDecoder()
    let mockResponse = try? decoder.decode(RecipeResponse.self, from: MockJSON.valid)
    let mockRecipes = mockResponse?.recipes.filter { $0.cuisine == "Malaysian" } ?? []

    NavigationView {
        RecipesByCuisineView(cuisine: "Malaysian", recipes: mockRecipes)
    }
}

