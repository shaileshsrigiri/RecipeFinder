//
//  RecipeDetailView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State private var image: UIImage?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let largeURL = recipe.largePhotoURL {
                    AsyncImageView(url: largeURL)
                        .frame(height: 250)
                        .cornerRadius(16)
                        .clipped()
                }
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title3)
                    .foregroundColor(.secondary)

                if let source = recipe.sourceURL {
                    Link("View Source", destination: source)
                        .font(.body)
                        .padding(.top)
                }

                if let youtube = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtube)
                        .font(.body)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    Group {
        if let mockResponse = try? JSONDecoder().decode(RecipeResponse.self, from: MockJSON.valid),
           let mockRecipe = mockResponse.recipes.first {
            NavigationView {
                RecipeDetailView(recipe: mockRecipe)
            }
        } else {
            Text("Failed to load mock recipe")
        }
    }
}




