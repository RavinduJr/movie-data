//
//  MovieLocalDataSourceProtocol.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

protocol LocalMovieDataSourceProtocol {
    func saveMovie(movie: Movie) throws
    func fetchMovies() throws -> [Movie]
    func toggleFavorites(movie: Movie) throws
    func fetchFavorites() throws -> [Movie]
}
