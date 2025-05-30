//
//  EmptyStateView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//


import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("😕 No Recipes Available")
                .font(.title3)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
