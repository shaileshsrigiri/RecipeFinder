//
//  MockJSON.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

enum MockJSON {
    static let valid: Data = """
    {
        "recipes": [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://example.com/large.jpg",
                "photo_url_small": "https://example.com/small.jpg",
                "source_url": "https://example.com/source",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://youtube.com/example"
            }
        ]
    }
    """.data(using: .utf8)!

    
    static let malformed: Data = """
    {
        "recipes": [
            {
                "cuisine": "British"
            }
        ]
    }
    """.data(using: .utf8)!

    
    static let empty: Data = """
    {
        "recipes": []
    }
    """.data(using: .utf8)!
}
