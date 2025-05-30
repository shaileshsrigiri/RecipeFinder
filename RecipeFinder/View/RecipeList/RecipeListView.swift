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
                    ErrorView(message: error) {
                        Task { await viewModel.loadRecipes() }
                    }
                } else if viewModel.filteredRecipes.isEmpty {
                    EmptyStateView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.filteredRecipes) { recipe in
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
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("🍽️ Recipes")
            .searchable(text: $viewModel.searchText)
            .task { await viewModel.loadRecipes() }
            .refreshable { await viewModel.loadRecipes() }
        }
    }
}

#Preview() {
    RecipeListView()
}
