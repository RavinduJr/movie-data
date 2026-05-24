//
//  MockToggleFavoritesUseCase.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

@testable import movie_data

final class MockToggleFavoritesUseCase: ToggleFavoritesUseCase {

    var executeResult: Result<Void, Error> = .success(())

    init() {
        super.init(movieRepository: MockMovieRepository())
    }

    override func execute(movie: Movie) throws {
        try executeResult.get()
    }
}
