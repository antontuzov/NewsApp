//
//  APIResponse.swift
//  NewsApp
//
//  Created by Anton Tuzov on 14.05.2021.
//

import Foundation



// MARK: - APIResponse
struct APIResponse: Codable {
//    let status: String?
//    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
//    let publishedAt: Date?
    let content: String?

   
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
}
