//
//  ImageCacheManagerTests.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//


import XCTest
@testable import RecipeFinder

final class ImageCacheManagerTests: XCTestCase {

    var imageURL: URL!
    var cacheManager: ImageCacheManager!

    override func setUpWithError() throws {
        cacheManager = ImageCacheManager.shared
        imageURL = URL(string: "https://example.com/test-image.jpg")
        let fileURL = cacheManager.cacheDirectoryInternal.appendingPathComponent(imageURL.lastPathComponent)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(at: fileURL)
        }
    }

    func testImageCaching_shouldSaveAndLoadImage() async throws {
        guard let bundleImageURL = Bundle(for: type(of: self)).url(forResource: "test_image", withExtension: "jpg"),
              let imageData = try? Data(contentsOf: bundleImageURL) else {
            XCTFail("❌ Failed to load test image from bundle")
            return
        }

        let cacheManager = ImageCacheManager.shared
        let mockURL = URL(string: "https://example.com/test_image.jpg")!
        
        let hashedFileName = "\(mockURL.absoluteString.hashValue).jpg"
        let fileURL = cacheManager.test_cacheDirectory.appendingPathComponent(hashedFileName)

        try imageData.write(to: fileURL)
        XCTAssertTrue(FileManager.default.fileExists(atPath: fileURL.path), "❌ Image file not found on disk")

        let loadedImage = await cacheManager.loadImage(from: mockURL)
        XCTAssertNotNil(loadedImage, "❌ Image failed to load from cache")
    }



    func testInvalidURL_shouldReturnNil() async {
        let invalidURL = URL(string: "https://example.com/does-not-exist.jpg")!
        let image = await cacheManager.loadImage(from: invalidURL)
        XCTAssertNil(image)
    }

}
