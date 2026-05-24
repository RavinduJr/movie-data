//
//  FetchFavoritesUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

class FetchFavoritesUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() throws -> [Movie] {
        try movieRepository.fetchFavorites()
    }
}
