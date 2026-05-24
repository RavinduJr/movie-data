//
//  SearchMovieUseCases.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

class SearchMovieUseCases {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(movieSearchRequest: MovieSearchRequest) async throws -> [Movie] {
        let movies = try await movieRepository.searchMovies(movieSearchRequest: movieSearchRequest)
        return movies
    }
}
