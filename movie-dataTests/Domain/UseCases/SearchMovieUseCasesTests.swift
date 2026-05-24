//
//  SearchMovieUseCasesTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class SearchMovieUseCasesTests: XCTestCase {

    private var repository: MockMovieRepository!
    private var useCase: SearchMovieUseCases!

    override func setUp() {
        super.setUp()

        repository = MockMovieRepository()
        useCase = SearchMovieUseCases(movieRepository: repository)
    }

    override func tearDown() {
        repository = nil
        useCase = nil

        super.tearDown()
    }

    func test_execute_returnsMoviesSuccessfully() async throws {

        // GIVEN
        repository.searchMoviesResult = .success(MovieFixture.movies)

        let request = MovieSearchRequest(
            query: "Batman",
            includeAdult: false,
            language: "en-US",
            page: 1
        )

        // WHEN
        let movies = try await useCase.execute(movieSearchRequest: request)

        // THEN
        XCTAssertEqual(movies.count, 2)
        XCTAssertEqual(movies.first?.title, "Batman Begins")
    }

    func test_execute_throwsError_whenRepositoryFails() async {

        // GIVEN
        repository.searchMoviesResult = .failure(MockError.somethingWentWrong)

        let request = MovieSearchRequest(
            query: "Batman",
            includeAdult: false,
            language: "en-US",
            page: 1
        )

        // WHEN / THEN
        do {
            _ = try await useCase.execute(movieSearchRequest: request)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? MockError, .somethingWentWrong)
        }
    }
}
