//
//  AppContainer.swift
//  movie-data
//
//  Created by Ravindu on 5/23/26.
//

import Foundation
import CoreData

final class AppContainer {
    lazy var urlSession: APIClient = {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 10.0
        let session = URLSession(configuration: sessionConfiguration)
        return URLSessionAPIClient(session: session)
    }()
    
    private let coreDataStackContext = CoreDataStack.shared.context
    
    lazy var coreDataMovieManager: CoreDataMovieManager = {
        CoreDataMovieManager(context: self.coreDataStackContext)
    }()
    
    lazy var remoteDataSource: RemoteMovieDataSourceProtocol = {
        RemoteMovieDataSource(apiClient: self.urlSession)
    }()
    
    lazy var localDataSource: LocalMovieDataSourceProtocol = {
        LocalMovieDataSource(movieManager: self.coreDataMovieManager)
    }()
    
    lazy var movieImpl: MovieRepository = {
        MovieRepositoriesImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
    }()
    
    lazy var searchMovieUseCase: SearchMovieUseCases = {
        SearchMovieUseCases(movieRepository: self.movieImpl)
    }()
    
    lazy var saveMovieUseCase: SaveMovieUseCase = {
        SaveMovieUseCase(movieRepository: self.movieImpl)
    }()
    
    lazy var fetchMovieUseCase: FetchMoviesUseCase = {
        FetchMoviesUseCase(movieRepository: self.movieImpl)
    }()
    
    lazy var toggleFavoritesUseCase: ToggleFavoritesUseCase = {
        ToggleFavoritesUseCase(movieRepository: self.movieImpl)
    }()
    
    lazy var fetchFavoritesUseCase: FetchFavoritesUseCase = {
        FetchFavoritesUseCase(movieRepository: self.movieImpl)
    }()
    
    lazy var searchMovieViewModel: SearchMoviesViewModel = {
        SearchMoviesViewModel(
            searchMovieUseCase: self.searchMovieUseCase,
            saveMovieUseCase: self.saveMovieUseCase,
            fetchMoviesUseCase: self.fetchMovieUseCase,
            toggleFavoriteUseCase: self.toggleFavoritesUseCase
        )
    }()
    
    lazy var favoritesViewModel: FavoritesViewModel = {
        FavoritesViewModel(
            toggleFavoitesUseCase: self.toggleFavoritesUseCase,
            fetchFavoitesUseCase: self.fetchFavoritesUseCase
        )
    }()
}
