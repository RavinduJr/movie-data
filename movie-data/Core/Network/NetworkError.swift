//
//  NetworkError.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

enum NetworkError: Error, LocalizedError, Equatable {

    case invalidURL
    case invalidResponse
    case decodingError
    case serverError(Int)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"

        case .invalidResponse:
            return "Invalid Response"

        case .decodingError:
            return "Failed to decode response"

        case .serverError(let code):
            return "Server error: \(code)"

        case .unknown:
            return "Unknown error occurred"
        }
    }
}
