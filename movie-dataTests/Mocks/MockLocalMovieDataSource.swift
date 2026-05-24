//
//  MockLocalMovieDataSource.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

final class MockLocalMovieDataSource: LocalMovieDataSourceProtocol {

    var saveMovieResult: Result<Void, Error> = .success(())
    var fetchMoviesResult: Result<[Movie], Error> = .success([])
    var toggleFavoritesResult: Result<Void, Error> = .success(())
    var fetchFavoritesResult: Result<[Movie], Error> = .success([])

    func saveMovie(movie: Movie) throws {
        try saveMovieResult.get()
    }

    func fetchMovies() throws -> [Movie] {
        try fetchMoviesResult.get()
    }

    func toggleFavorites(movie: Movie) throws {
        try toggleFavoritesResult.get()
    }

    func fetchFavorites() throws -> [Movie] {
        try fetchFavoritesResult.get()
    }
}
