//
//  SaveMovieUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

class SaveMovieUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movie: Movie) throws {
        try self.movieRepository.saveMovie(movie: movie)
    }
}
