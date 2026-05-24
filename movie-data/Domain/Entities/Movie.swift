//
//  Movie.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

struct Movie: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String?
    var releaseDate:  String
    var isFavorite: Bool
    
    var releaseYear: String {
        // comes substrings and then to convert it to string map it with String type
        releaseDate.split(separator: "-").first.map(String.init) ?? ""
    }
}
