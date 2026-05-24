//
//  MovieEntityFixture.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import CoreData
@testable import movie_data

enum MovieEntityFixture {

    static func makeMovieEntities(
        context: NSManagedObjectContext
    ) -> [MovieEntity] {

        let movie1 = MovieEntity(context: context)
        movie1.id = 1
        movie1.title = "Batman Begins"
        movie1.overview = "Bruce Wayne becomes Batman"
        movie1.posterPath = "/batman.jpg"
        movie1.releaseDate = "2005-06-15"
        movie1.isFavorite = true

        let movie2 = MovieEntity(context: context)
        movie2.id = 2
        movie2.title = "The Dark Knight"
        movie2.overview = "Batman faces the Joker"
        movie2.posterPath = "/dark-knight.jpg"
        movie2.releaseDate = "2008-07-18"
        movie2.isFavorite = false

        let movie3 = MovieEntity(context: context)
        movie3.id = 3
        movie3.title = "Interstellar"
        movie3.overview = "A journey through space and time"
        movie3.posterPath = "/interstellar.jpg"
        movie3.releaseDate = "2014-11-07"
        movie3.isFavorite = true

        return [movie1, movie2, movie3]
    }
    
    static func makeFavoriteMovieEntity(
        context: NSManagedObjectContext
    ) -> MovieEntity {

        let entity = MovieEntity(context: context)

        entity.id = 2
        entity.title = "The Dark Knight"
        entity.overview = "The Joker appears"
        entity.posterPath = "/joker.jpg"
        entity.releaseDate = "2008-07-18"
        entity.isFavorite = true

        return entity
    }
}
