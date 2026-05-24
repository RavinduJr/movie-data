//
//  MovieFixtures.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

enum MovieFixture {

    static let movie = Movie(
        id: 1,
        title: "Batman Begins",
        overview: "Bruce Wayne becomes Batman",
        posterPath: "/batman.jpg",
        releaseDate: "2005-06-15",
        isFavorite: false
    )

    static let favoriteMovie = Movie(
        id: 2,
        title: "The Dark Knight",
        overview: "The Joker appears",
        posterPath: "/joker.jpg",
        releaseDate: "2008-07-18",
        isFavorite: true
    )

    static let movies = [
        movie,
        favoriteMovie
    ]
}
