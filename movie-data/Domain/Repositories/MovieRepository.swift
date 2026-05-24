//
//  MovieRepository.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

protocol MovieRepository {
    func searchMovies(movieSearchRequest: MovieSearchRequest) async throws -> [Movie]
    func saveMovie(movie: Movie) throws -> Void
    func fetchMovies() throws -> [Movie]
    func toggleFavorites(movie: Movie) throws -> Void
    func fetchFavorites() throws -> [Movie]
}
