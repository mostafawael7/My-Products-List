//
//  APIError.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case statusCode(Int)
    case decodingFailed(Error)
    
    var userFriendlyMessage: String {
        switch self {
        case .invalidURL:
            return "The API URL is invalid."
        case .requestFailed(let err):
            return "Couldn't reach the server. Please check your connection.\n\(err.localizedDescription)"
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .statusCode(let code):
            return "Server error (code \(code)). Please try again later."
        case .decodingFailed(let err):
            return "Something went wrong while processing the data.\n\(err.localizedDescription)"
        }
    }
}
