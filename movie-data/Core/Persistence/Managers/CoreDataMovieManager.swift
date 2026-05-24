//
//  CoreDataManager.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import CoreData

class CoreDataMovieManager {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveMovies(movie: Movie) throws {
        let request: NSFetchRequest<MovieEntity> =
            MovieEntity.fetchRequest()

        request.predicate = NSPredicate(
            format: "id == %d",
            movie.id
        )

        let existingMovies = try context.fetch(request)

        guard existingMovies.isEmpty else {
            return
        }
        
        let entity = MovieEntity(context: context)
        entity.id = Int32(movie.id)
        entity.title = movie.title
        entity.overview = movie.overview
        entity.releaseDate = movie.releaseDate
        entity.posterPath = movie.posterPath
        entity.isFavorite = movie.isFavorite
        do {
            try context.save()
        } catch {
            throw PersistenceError.saveFailed
        }
    }
    
    func fetchMovies() throws -> [MovieEntity] {
        let fetchRequest = MovieEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw PersistenceError.fetchFailed
        }
    }
    
    func toggleFavorites(movie: Movie) throws {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        request.predicate = NSPredicate(
            format: "id == %d", movie.id
        )
        
        request.fetchLimit = 1
        
        var existingMovie: MovieEntity?
        do {
            existingMovie = try context.fetch(request).first
        } catch {
            throw PersistenceError.fetchFailed
        }
        
        if let existingMovie {
            
            existingMovie.isFavorite.toggle()
            
        } else {
            
            let entity = MovieEntity(context: context)
            
            entity.id = Int32(movie.id)
            entity.title = movie.title
            entity.overview = movie.overview
            entity.releaseDate = movie.releaseDate
            entity.posterPath = movie.posterPath
            
            entity.isFavorite = true
        }
        
        do {
            try context.save()
        } catch {
            throw PersistenceError.saveFailed
        }
    }
    
    func fetchFavoriteMovies() throws -> [MovieEntity] {

        let request: NSFetchRequest<MovieEntity> =
            MovieEntity.fetchRequest()

        request.predicate = NSPredicate(
            format: "isFavorite == %@",
            NSNumber(value: true)
        )

        do {
            return try context.fetch(request)
        } catch {
            throw PersistenceError.fetchFailed
        }
    }
}
