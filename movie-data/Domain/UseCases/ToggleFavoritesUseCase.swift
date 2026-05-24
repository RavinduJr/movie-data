//
//  AddToFavoritesUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

class ToggleFavoritesUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movie: Movie) throws {
        try movieRepository.toggleFavorites(movie: movie)
    }
}
