//
//  ImageCacheManager.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation
import SwiftUI
import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let fileManager = FileManager.default
    let cacheDirectoryInternal: URL

    private init() {
        cacheDirectoryInternal = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("ImageCache")

        try? fileManager.createDirectory(at: cacheDirectoryInternal, withIntermediateDirectories: true)
    }

    func loadImage(from url: URL) async -> UIImage? {
        // ✅ Use hash of full URL for unique file name
        let fileName = "\(url.absoluteString.hashValue).jpg"
        let fileURL = cacheDirectoryInternal.appendingPathComponent(fileName)

        if fileManager.fileExists(atPath: fileURL.path),
           let data = try? Data(contentsOf: fileURL),
           let image = UIImage(data: data) {
            return image
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try? data.write(to: fileURL)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }

    // Exposed for testing
    #if DEBUG
    var test_cacheDirectory: URL {
        return cacheDirectoryInternal
    }
    #endif
}
