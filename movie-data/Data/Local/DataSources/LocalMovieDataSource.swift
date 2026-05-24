//
//  LocalMovieDataSource.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

final class LocalMovieDataSource: LocalMovieDataSourceProtocol {
    private let coreDataMovieManager: CoreDataMovieManager
    
    init(movieManager: CoreDataMovieManager) {
        self.coreDataMovieManager = movieManager
    }
    
    func saveMovie(movie: Movie) throws {
        try self.coreDataMovieManager.saveMovies(movie: movie)
    }
    
    func fetchMovies() throws -> [Movie] {
        let entityMovies = try self.coreDataMovieManager.fetchMovies()
        return entityMovies.map {
            $0.toDomain()
        }
    }
    
    func toggleFavorites(movie: Movie) throws {
        try self.coreDataMovieManager.toggleFavorites(movie: movie)
    }
    
    func fetchFavorites() throws -> [Movie] {
        let favoriteMovies = try self.coreDataMovieManager.fetchFavoriteMovies()
        return favoriteMovies.map {
            $0.toDomain()
        } 
    }
}
