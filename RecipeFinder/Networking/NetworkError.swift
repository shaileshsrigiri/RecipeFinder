//
//  NetworkError.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed
    case noData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .requestFailed(let statusCode):
            return "Request failed with status code \(statusCode)."
        case .decodingFailed:
            return "Failed to decode the response."
        case .noData:
            return "No data received from server."
        }
    }
}
