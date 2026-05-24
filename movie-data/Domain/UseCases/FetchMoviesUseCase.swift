//
//  FetchMoviesUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

class FetchMoviesUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute() throws -> [Movie] {
        try movieRepository.fetchMovies()
    }
}
