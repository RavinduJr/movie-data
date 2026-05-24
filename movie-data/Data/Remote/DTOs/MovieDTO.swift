//
//  MovieDTO.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

// MARK: - Root Response

struct MovieSearchResponse: Codable {
    
    let page: Int
    let results: [MovieDTO]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie DTO

struct MovieDTO: Codable, Identifiable {
    
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let title: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let softcore: Bool
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case softcore
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
