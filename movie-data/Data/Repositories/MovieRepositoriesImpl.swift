//
//  MovieRepositoriesImpl.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

final class MovieRepositoriesImpl: MovieRepository {
    private let remoteDataSource: RemoteMovieDataSourceProtocol
    private let localDataSource: LocalMovieDataSourceProtocol
    
    init(remoteDataSource: RemoteMovieDataSourceProtocol, localDataSource: LocalMovieDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func searchMovies(movieSearchRequest: MovieSearchRequest) async throws -> [Movie] {
        let movieResponse = try await remoteDataSource.searchMovies(movieSearchRequest: movieSearchRequest)
        return movieResponse.map { $0.toDomain() }
    }
    
    func saveMovie(movie: Movie) throws {
        try localDataSource.saveMovie(movie: movie)
    }
    
    func fetchMovies() throws -> [Movie] {
        return try localDataSource.fetchMovies()
    }
    
    func toggleFavorites(movie: Movie) throws {
        try localDataSource.toggleFavorites(movie: movie)
    }
    
    func fetchFavorites() throws -> [Movie] {
        return try localDataSource.fetchFavorites()
    }
}
