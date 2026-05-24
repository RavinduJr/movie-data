//
//  SearchMoviesViewModelTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

@MainActor
final class SearchMoviesViewModelTests: XCTestCase {

    private var sut: SearchMoviesViewModel!

    private var searchMovieUseCase: MockSearchMovieUseCase!
    private var saveMovieUseCase: MockSaveMovieUseCase!
    private var fetchMoviesUseCase: MockFetchMoviesUseCase!
    private var toggleFavoriteUseCase: MockToggleFavoritesUseCase!

    override func setUp() {
        super.setUp()

        searchMovieUseCase = MockSearchMovieUseCase()
        saveMovieUseCase = MockSaveMovieUseCase()
        fetchMoviesUseCase = MockFetchMoviesUseCase()
        toggleFavoriteUseCase = MockToggleFavoritesUseCase()

        sut = SearchMoviesViewModel(
            searchMovieUseCase: searchMovieUseCase,
            saveMovieUseCase: saveMovieUseCase,
            fetchMoviesUseCase: fetchMoviesUseCase,
            toggleFavoriteUseCase: toggleFavoriteUseCase
        )
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_searchMovies_updatesMoviesSuccessfully() async {

        // GIVEN

        searchMovieUseCase.executeResult = .success(MovieFixture.movies)

        sut.searchQuery = "Batman"

        // WHEN

        await sut.searchMovies()

        // THEN

        XCTAssertEqual(sut.movies.count, 2)

        XCTAssertEqual(sut.movies.first?.title, "Batman Begins")

        XCTAssertFalse(sut.isLoading)

    }
    
    func test_searchMovies_setsError_whenUseCaseFails() async {

        // GIVEN
        searchMovieUseCase.executeResult = .failure(MockError.somethingWentWrong)

        sut.searchQuery = "Batman"

        // WHEN
        await sut.searchMovies()

        // THEN
        XCTAssertTrue(sut.showError)
        XCTAssertEqual(sut.errorMessage, "Something went wrong")
        XCTAssertFalse(sut.isLoading)
    }
    
    func test_fetchStoredMovies_updatesStoredMoviesSuccessfully() {

        // GIVEN
        fetchMoviesUseCase.executeResult = .success(MovieFixture.movies)

        // WHEN
        sut.fetchStoredMovies()

        // THEN
        XCTAssertEqual(sut.storedMovies.count, 2)
        XCTAssertEqual(sut.storedMovies.first?.title, "Batman Begins")
    }
    
    func test_fetchStoredMovies_setsError_whenFetchFails() {

        // GIVEN
        fetchMoviesUseCase.executeResult = .failure(MockError.somethingWentWrong)

        // WHEN
        sut.fetchStoredMovies()

        // THEN
        XCTAssertTrue(sut.showError)
    }
    
    func test_saveMovie_savesSuccessfully() {

        // GIVEN
        saveMovieUseCase.executeResult = .success(())

        // WHEN
        sut.saveMovie(movie: MovieFixture.movie)

        // THEN
        XCTAssertFalse(sut.showError)
    }
    
    func test_saveMovie_setsError_whenSaveFails() {

        // GIVEN
        saveMovieUseCase.executeResult = .failure(MockError.somethingWentWrong)

        // WHEN
        sut.saveMovie(movie: MovieFixture.movie)

        // THEN
        XCTAssertTrue(sut.showError)
    }
    
    func test_toggleFavoriteMovies_updatesMovieFavoriteStatus() {

        // GIVEN
        sut.movies = [MovieFixture.movie]

        toggleFavoriteUseCase.executeResult = .success(())

        // WHEN
        sut.toggleFavoriteMovies(movie: MovieFixture.movie)

        // THEN
        XCTAssertTrue(sut.movies.first?.isFavorite == true)
    }
    
    func test_toggleFavoriteMovies_setsError_whenToggleFails() {

        // GIVEN
        toggleFavoriteUseCase.executeResult = .failure(MockError.somethingWentWrong)

        // WHEN
        sut.toggleFavoriteMovies(movie: MovieFixture.movie)

        // THEN
        XCTAssertTrue(sut.showError)
    }
    
    func test_resetPage_resetsPaginationState() {

        // GIVEN
        sut.movies = MovieFixture.movies
        sut.currentPage = 5

        // WHEN
        sut.resetPage()

        // THEN
        XCTAssertEqual(sut.currentPage, 1)
        XCTAssertTrue(sut.movies.isEmpty)
    }
}
