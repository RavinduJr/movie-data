//
//  MockFetchMoviesUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

final class MockFetchMoviesUseCase: FetchMoviesUseCase {

    var executeResult: Result<[Movie], Error> = .success([])

    init() {
        super.init(movieRepository: MockMovieRepository())
    }

    override func execute() throws -> [Movie] {
        try executeResult.get()
    }
}
