//
//  MovieDTOFixtures.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

enum MovieDTOFixture {

    static let movieDTO = MovieDTO(
        adult: false,
        backdropPath: "/b3auXVnVRM7CJ6Pkiqr6wVQWJLU.jpg",
        genreIds: [28, 80, 18],
        id: 1,
        title: "Batman Begins",
        originalLanguage: "en",
        originalTitle: "Batman Begins",
        overview: "Bruce Wayne becomes Batman",
        popularity: 92.4,
        posterPath: "/batman.jpg",
        releaseDate: "2005-06-15",
        softcore: false,
        video: false,
        voteAverage: 8.2,
        voteCount: 21000
    )

    static let movieDTOs = [
        movieDTO
    ]
}
