//
//  MockRemoteMovieDataSource.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

final class MockRemoteMovieDataSource: RemoteMovieDataSourceProtocol {

    var searchMoviesResult: Result<[MovieDTO], Error> = .success([])

    func searchMovies(movieSearchRequest: MovieSearchRequest) async throws -> [MovieDTO] {
        try searchMoviesResult.get()
    }
}
