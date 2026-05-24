//
//  MovieEndpoint.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

enum MovieEndpoint: Endpoint {
    case searchMovies(movieSearchRequest: MovieSearchRequest)
    
    var baseUrl: String {
        APIConstants.baseUrl
    }
    
    var path: String {
        switch self {
        case .searchMovies:
            return "search/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .searchMovies:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchMovies(let movieSearchRequest):
            var queryItems = [
                URLQueryItem(name: "query", value: movieSearchRequest.query),
                URLQueryItem(name: "include_adult", value: movieSearchRequest.includeAdult ? "true" : "false"),
                URLQueryItem(name: "language", value: movieSearchRequest.language),
                URLQueryItem(name: "page", value: "\(movieSearchRequest.page)")]
            if let region = movieSearchRequest.region {
                queryItems.append(
                    URLQueryItem(name: "region", value: region)
                )
            }

            if let year = movieSearchRequest.year {
                queryItems.append(
                    URLQueryItem(name: "year", value: year)
                )
            }

            if let primaryReleaseYear = movieSearchRequest.primaryReleaseYear {
                queryItems.append(
                    URLQueryItem(
                        name: "primary_release_year",
                        value: primaryReleaseYear
                    )
                )
            }
            return queryItems
        }
    }
    
    var body: Codable? {
        switch self {
        case .searchMovies:
            return nil
        }
    }
}
