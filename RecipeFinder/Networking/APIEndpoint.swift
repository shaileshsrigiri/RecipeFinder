//
//  APIEndpoint.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

enum APIEndpoint {
    static let recipes = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    static let malformed = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    static let empty = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
}
