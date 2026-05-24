//
//  MovieSearchRequest.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

struct MovieSearchRequest {
    var query: String
    var includeAdult: Bool
    var language: String
    var primaryReleaseYear: String?
    var page: Int
    var region: String?
    var year: String?
}
