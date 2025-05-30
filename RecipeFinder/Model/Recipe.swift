//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURL: URL?
    let largePhotoURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?

    enum CodingKeys: String, CodingKey {
        case name, cuisine, uuid, photo_url_small, photo_url_large, source_url, youtube_url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        id = try container.decode(UUID.self, forKey: .uuid)
        photoURL = try? container.decode(URL.self, forKey: .photo_url_small)
        largePhotoURL = try? container.decode(URL.self, forKey: .photo_url_large)
        sourceURL = try? container.decode(URL.self, forKey: .source_url)
        youtubeURL = try? container.decode(URL.self, forKey: .youtube_url)
    }
}


struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
