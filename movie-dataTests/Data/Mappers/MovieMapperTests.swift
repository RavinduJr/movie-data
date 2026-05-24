//
//  MovieMapperTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class MovieMapperTests: XCTestCase {

    func test_toDomain_mapsMovieDTOToMovieCorrectly() {

        // GIVEN
        let dto = MovieDTO(
            adult: false,
            backdropPath: "/backdrop.jpg",
            genreIds: [1, 2],
            id: 1,
            title: "Batman Begins",
            originalLanguage: "en",
            originalTitle: "Batman Begins",
            overview: "Bruce Wayne becomes Batman",
            popularity: 100.0,
            posterPath: "/batman.jpg",
            releaseDate: "2005-06-15",
            softcore: false,
            video: false,
            voteAverage: 8.2,
            voteCount: 1000
        )

        // WHEN
        let movie = dto.toDomain()

        // THEN
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Batman Begins")
        XCTAssertEqual(movie.overview, "Bruce Wayne becomes Batman")
        XCTAssertEqual(movie.posterPath, "/batman.jpg")
        XCTAssertEqual(movie.releaseDate, "2005-06-15")
        XCTAssertFalse(movie.isFavorite)
    }
}
