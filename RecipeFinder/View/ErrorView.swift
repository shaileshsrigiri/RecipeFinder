//
//  ErrorView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//


import SwiftUI

struct ErrorView: View {
    let message: String
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("🚫 \(message)")
                .multilineTextAlignment(.center)
                .font(.body)

            Button(action: onRetry) {
                Text("Retry")
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
