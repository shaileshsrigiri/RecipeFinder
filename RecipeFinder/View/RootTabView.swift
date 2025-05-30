//
//  RootTabView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            RecipeListView()
                .tabItem {
                    Label("All Recipes", systemImage: "list.bullet")
                }

            CuisineListView(viewModel: RecipeViewModel())
                .tabItem {
                    Label("Cuisines", systemImage: "square.grid.2x2")
                }
        }
    }
}

#Preview {
    RootTabView()
}
