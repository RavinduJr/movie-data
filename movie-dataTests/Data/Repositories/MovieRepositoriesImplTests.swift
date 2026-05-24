//
//  MovieRepositoriesImplTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class MovieRepositoriesImplTests: XCTestCase {

    private var sut: MovieRepositoriesImpl!

    private var remoteDataSource: MockRemoteMovieDataSource!
    private var localDataSource: MockLocalMovieDataSource!

    override func setUp() {
        super.setUp()

        remoteDataSource = MockRemoteMovieDataSource()
        localDataSource = MockLocalMovieDataSource()

        sut = MovieRepositoriesImpl(
            remoteDataSource: remoteDataSource,
            localDataSource: localDataSource
        )
    }

    override func tearDown() {
        sut = nil
        remoteDataSource = nil
        localDataSource = nil

        super.tearDown()
    }
    
    func test_searchMovies_returnsMappedMoviesSuccessfully() async throws {

        // GIVEN
        remoteDataSource.searchMoviesResult = .success(MovieDTOFixture.movieDTOs)

        let request = MovieSearchRequest(
            query: "Batman",
            includeAdult: false,
            language: "en-US",
            page: 1
        )

        // WHEN
        let movies = try await sut.searchMovies(movieSearchRequest: request)

        // THEN
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies.first?.title, "Batman Begins")
    }
    
    func test_searchMovies_throwsError_whenRemoteFails() async {

        // GIVEN
        remoteDataSource.searchMoviesResult = .failure(MockError.somethingWentWrong)

        let request = MovieSearchRequest(
            query: "Batman",
            includeAdult: false,
            language: "en-US",
            page: 1
        )

        // WHEN / THEN
        do {
            _ = try await sut.searchMovies(movieSearchRequest: request)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? MockError, .somethingWentWrong)
        }
    }
    
    func test_saveMovie_savesSuccessfully() throws {

        // GIVEN
        localDataSource.saveMovieResult = .success(())

        // WHEN / THEN
        XCTAssertNoThrow(
            try sut.saveMovie(movie: MovieFixture.movie)
        )
    }
    
    func test_fetchMovies_returnsMoviesSuccessfully() throws {

        // GIVEN
        localDataSource.fetchMoviesResult = .success(MovieFixture.movies)

        // WHEN
        let movies = try sut.fetchMovies()

        // THEN
        XCTAssertEqual(movies.count, 2)
    }
    
    func test_toggleFavorites_executesSuccessfully() throws {

        // GIVEN
        localDataSource.toggleFavoritesResult = .success(())

        // WHEN / THEN
        XCTAssertNoThrow(
            try sut.toggleFavorites(movie: MovieFixture.movie)
        )
    }
    
    func test_fetchFavorites_returnsFavoritesSuccessfully() throws {

        // GIVEN
        localDataSource.fetchFavoritesResult = .success([
            MovieFixture.favoriteMovie
        ])

        // WHEN
        let favorites = try sut.fetchFavorites()

        // THEN
        XCTAssertEqual(favorites.count, 1)
        XCTAssertTrue(favorites.first?.isFavorite == true)
    }
}
