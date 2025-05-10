//
//  Product.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menClothing = "men's clothing"
    case womenClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}
