//
//  RemoteMovieDataSourceProtocol.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

protocol RemoteMovieDataSourceProtocol {
    func searchMovies(movieSearchRequest: MovieSearchRequest) async throws -> [MovieDTO]
}
