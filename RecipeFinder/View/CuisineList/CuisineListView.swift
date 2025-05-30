//
//  CuisineListView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import SwiftUI

struct CuisineListView: View {
    @StateObject var viewModel: RecipeViewModel

    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.uniqueCuisines, id: \.self) { cuisine in
                        let imageURL = viewModel.representativeImage(for: cuisine)

                        NavigationLink(destination: RecipesByCuisineView(cuisine: cuisine, recipes: viewModel.recipesForCuisine(cuisine))) {
                            ZStack {
                                if let imageURL {
                                    AsyncImageView(url: imageURL)
                                        .aspectRatio(1, contentMode: .fill)
                                        .frame(width: 175, height: 175)
                                        .clipShape(Circle())
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 175, height: 175)
                                }

                                Circle()
                                    .fill(Color.black.opacity(0.4))
                                    .frame(width: 175, height: 175)

                                Text(cuisine)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                                    .frame(width: 100)
                            }
                            
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Browse by Cuisine")
            .task { await viewModel.loadRecipes() }
            .refreshable { await viewModel.loadRecipes() }
        }
    }
}


#Preview {
    let viewModel = RecipeViewModel(networkService: MockNetworkService(mockData: MockJSON.valid))
    return CuisineListView(viewModel: viewModel)
}

