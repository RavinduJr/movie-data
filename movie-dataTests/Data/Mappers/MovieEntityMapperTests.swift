//
//  MovieEntityMapperTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
import CoreData
@testable import movie_data

final class MovieEntityMapperTests: XCTestCase {

    private var persistentContainer: NSPersistentContainer!

    override func setUp() {
        super.setUp()

        persistentContainer = NSPersistentContainer(name: "movie_data")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        persistentContainer.persistentStoreDescriptions = [description]

        persistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }
    }

    override func tearDown() {
        persistentContainer = nil
        super.tearDown()
    }

    func test_toDomain_mapsMovieEntityToMovieCorrectly() {

        // GIVEN
        let context = persistentContainer.viewContext

        let entity = MovieEntity(context: context)

        entity.id = 1
        entity.title = "Batman Begins"
        entity.overview = "Bruce Wayne becomes Batman"
        entity.posterPath = "/batman.jpg"
        entity.releaseDate = "2005-06-15"
        entity.isFavorite = true

        // WHEN
        let movie = entity.toDomain()

        // THEN
        XCTAssertEqual(movie.id, 1)
        XCTAssertEqual(movie.title, "Batman Begins")
        XCTAssertEqual(movie.overview, "Bruce Wayne becomes Batman")
        XCTAssertEqual(movie.posterPath, "/batman.jpg")
        XCTAssertEqual(movie.releaseDate, "2005-06-15")
        XCTAssertTrue(movie.isFavorite)
    }
    
    func test_toDomain_mapsNilValuesToEmptyStrings() {

        // GIVEN
        let context = persistentContainer.viewContext

        let entity = MovieEntity(context: context)

        entity.id = 1
        entity.title = nil
        entity.overview = nil
        entity.releaseDate = nil
        entity.posterPath = nil
        entity.isFavorite = false

        // WHEN
        let movie = entity.toDomain()

        // THEN
        XCTAssertEqual(movie.title, "")
        XCTAssertEqual(movie.overview, "")
        XCTAssertEqual(movie.releaseDate, "")
        XCTAssertNil(movie.posterPath)
    }
}
