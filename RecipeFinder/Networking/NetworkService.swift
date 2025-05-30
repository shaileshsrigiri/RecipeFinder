//
//  NetworkService.swift
//  RecipeFinder
//
//  Created by Shailesh Srigiri on 5/30/25.
//


import Foundation

protocol NetworkService {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}
