//
//  LocalMovieDataSourceTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class LocalMovieDataSourceTests: XCTestCase {

    private var sut: LocalMovieDataSource!
    private var coreDataManager: MockCoreDataMovieManager!

    override func setUp() {
        super.setUp()

        coreDataManager = MockCoreDataMovieManager()

        sut = LocalMovieDataSource(
            movieManager: coreDataManager
        )
    }

    override func tearDown() {
        sut = nil
        coreDataManager = nil

        super.tearDown()
    }
    
    func test_saveMovie_executesSuccessfully() {

        // GIVEN
        coreDataManager.saveMoviesResult = .success(())

        // WHEN / THEN
        XCTAssertNoThrow(
            try sut.saveMovie(movie: MovieFixture.movie)
        )
    }
    
    func test_saveMovie_throwsError_whenSaveFails() {

        // GIVEN
        coreDataManager.saveMoviesResult = .failure(PersistenceError.saveFailed)

        // WHEN / THEN
        XCTAssertThrowsError(
            try sut.saveMovie(movie: MovieFixture.movie)
        ) { error in

            XCTAssertEqual(
                error as? PersistenceError,
                .saveFailed
            )
        }
    }
    
    func test_fetchMovies_returnsMoviesSuccessfully() throws {

        // GIVEN
        coreDataManager.fetchMoviesResult = .success(MovieEntityFixture.makeMovieEntities(context: coreDataManager.context))

        // WHEN
        let movies = try sut.fetchMovies()

        // THEN
        XCTAssertEqual(movies.count, 3)
        XCTAssertEqual(movies.first?.title, "Batman Begins")
    }
    
    func test_fetchMovies_throwsError_whenFetchFails() {

        // GIVEN
        coreDataManager.fetchMoviesResult = .failure(PersistenceError.fetchFailed)

        // WHEN / THEN
        XCTAssertThrowsError(
            try sut.fetchMovies()
        ) { error in

            XCTAssertEqual(
                error as? PersistenceError,
                .fetchFailed
            )
        }
    }
    
    func test_toggleFavorites_executesSuccessfully() {

        // GIVEN
        coreDataManager.toggleFavoritesResult = .success(())

        // WHEN / THEN
        XCTAssertNoThrow(
            try sut.toggleFavorites(movie: MovieFixture.movie)
        )
    }
    
    func test_fetchFavorites_returnsFavoritesSuccessfully() throws {

        // GIVEN
        coreDataManager.fetchFavoriteMoviesResult = .success([
            MovieEntityFixture.makeFavoriteMovieEntity(context: coreDataManager.context)
        ])

        // WHEN
        let favorites = try sut.fetchFavorites()

        // THEN
        XCTAssertEqual(favorites.count, 1)
        XCTAssertTrue(favorites.first?.isFavorite == true)
    }
    
    func test_fetchFavorites_throwsError_whenFetchFails() {

        // GIVEN
        coreDataManager.fetchFavoriteMoviesResult = .failure(
            PersistenceError.fetchFailed
        )

        // WHEN / THEN
        XCTAssertThrowsError(
            try sut.fetchFavorites()
        )
    }
}
