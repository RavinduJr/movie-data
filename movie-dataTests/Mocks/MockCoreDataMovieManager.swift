//
//  MockCoreDataMovieManager.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import CoreData
@testable import movie_data

final class MockCoreDataMovieManager: CoreDataMovieManager {

    init() {

        let container = NSPersistentContainer(name: "movie_data")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }

        super.init(context: container.viewContext)
    }

    var saveMoviesResult: Result<Void, Error> = .success(())
    var fetchMoviesResult: Result<[MovieEntity], Error> = .success([])
    var toggleFavoritesResult: Result<Void, Error> = .success(())
    var fetchFavoriteMoviesResult: Result<[MovieEntity], Error> = .success([])

    override func saveMovies(movie: Movie) throws {
        try saveMoviesResult.get()
    }

    override func fetchMovies() throws -> [MovieEntity] {
        try fetchMoviesResult.get()
    }

    override func toggleFavorites(movie: Movie) throws {
        try toggleFavoritesResult.get()
    }

    override func fetchFavoriteMovies() throws -> [MovieEntity] {
        try fetchFavoriteMoviesResult.get()
    }
}
