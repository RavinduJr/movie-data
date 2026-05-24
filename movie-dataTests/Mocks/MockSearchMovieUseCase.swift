//
//  MockSearchMovieUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

final class MockSearchMovieUseCase: SearchMovieUseCases {

    var executeResult: Result<[Movie], Error> = .success([])

    init() {
        super.init(movieRepository: MockMovieRepository())
    }

    override func execute(movieSearchRequest: MovieSearchRequest) async throws -> [Movie] {
        try executeResult.get()
    }
}
