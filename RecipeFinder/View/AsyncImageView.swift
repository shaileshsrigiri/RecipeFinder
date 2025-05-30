//
//  AsyncImageView.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        ProgressView()
                    )
                    .onAppear {
                        Task {
                            if let url = url {
                                self.image = await ImageCacheManager.shared.loadImage(from: url)
                            }
                        }
                    }
            }
        }
    }
}
