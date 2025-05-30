//
//  RecipeListView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            Group {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.recipes) { recipe in
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
                                            .lineLimit(0)
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
                }
            }
            .navigationTitle("🍽️ Recipes")
            .task { await viewModel.loadRecipes() }
            .refreshable { await viewModel.loadRecipes() }
        }
    }
}

#Preview() {
    RecipeListView()
}
