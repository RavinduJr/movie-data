//
//  CoreDataMovieManagerTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
import CoreData
@testable import movie_data

final class CoreDataMovieManagerTests: XCTestCase {

    private var sut: CoreDataMovieManager!
    private var persistentContainer: NSPersistentContainer!
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        persistentContainer = NSPersistentContainer(name: "movie_data")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }

        context = persistentContainer.viewContext

        sut = CoreDataMovieManager(context: context)
    }

    override func tearDown() {
        sut = nil
        context = nil
        persistentContainer = nil

        super.tearDown()
    }
    
    func test_saveMovies_savesMovieSuccessfully() throws {

        // WHEN
        try sut.saveMovies(movie: MovieFixture.movie)

        // THEN
        let movies = try context.fetch(MovieEntity.fetchRequest())

        XCTAssertEqual(movies.count, 1)

        let savedMovie = movies.first as? MovieEntity

        XCTAssertEqual(savedMovie?.title, "Batman Begins")
    }
    
    func test_saveMovies_doesNotSaveDuplicateMovies() throws {

        // WHEN
        try sut.saveMovies(movie: MovieFixture.movie)
        try sut.saveMovies(movie: MovieFixture.movie)

        // THEN
        let movies = try context.fetch(MovieEntity.fetchRequest())

        XCTAssertEqual(movies.count, 1)
    }
    
    func test_fetchMovies_returnsSavedMovies() throws {

        // GIVEN
        try sut.saveMovies(movie: MovieFixture.movie)

        // WHEN
        let movies = try sut.fetchMovies()

        // THEN
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies.first?.title, "Batman Begins")
    }
    
    func test_toggleFavorites_updatesExistingMovieFavoriteStatus() throws {

        // GIVEN
        try sut.saveMovies(movie: MovieFixture.movie)

        // WHEN
        try sut.toggleFavorites(movie: MovieFixture.movie)

        // THEN
        let movies = try sut.fetchMovies()

        XCTAssertTrue(movies.first?.isFavorite == true)
    }
    
    func test_toggleFavorites_createsMovieIfMovieDoesNotExist() throws {

        // WHEN
        try sut.toggleFavorites(movie: MovieFixture.movie)

        // THEN
        let movies = try sut.fetchMovies()

        XCTAssertEqual(movies.count, 1)
        XCTAssertTrue(movies.first?.isFavorite == true)
    }
    
    func test_fetchFavoriteMovies_returnsOnlyFavoriteMovies() throws {

        // GIVEN
        try sut.saveMovies(movie: MovieFixture.movie)

        try sut.toggleFavorites(movie: MovieFixture.movie)

        // WHEN
        let favoriteMovies = try sut.fetchFavoriteMovies()

        // THEN
        XCTAssertEqual(favoriteMovies.count, 1)
        XCTAssertTrue(favoriteMovies.first?.isFavorite == true)
    }
}
