//
//  NetworkManager.swift
//  My Products List
//
//  Created by Mostafa Hendawi on 10/05/2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        body: Data? = nil,
        responseType: T.Type,
        retries: Int = 3,
        delay: TimeInterval = 2
    ) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.timeoutInterval = 15
        request.httpMethod = method.rawValue
        request.httpBody = body
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        var attempt = 0
        var lastError: Error?

        while attempt <= retries {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                guard (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.statusCode(httpResponse.statusCode)
                }

                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    return decoded
                } catch {
                    throw APIError.decodingFailed(error)
                }

            } catch {
                lastError = error
                attempt += 1

                if attempt > retries {
                    throw lastError ?? APIError.requestFailed(error)
                }

                // Wait before retrying
                try? await Task.sleep(nanoseconds: UInt64(delay * Double(attempt) * 1_000_000_000))
            }
        }

        // Should never hit this
        throw lastError ?? APIError.invalidResponse
    }
}
