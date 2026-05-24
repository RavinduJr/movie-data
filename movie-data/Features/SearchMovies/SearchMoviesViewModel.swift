//
//  SearchMoviesViewModel.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI
import Combine

final class SearchMoviesViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var showSearch: Bool = false
    @Published var movies: [Movie] = []
    @Published var selectedMovie: Movie?
    @Published var storedMovies: [Movie] = []
    @Published var errorMessage: String?
    @Published var showError = false
    
    private var searchMovieUseCase: SearchMovieUseCases
    private var saveMovieUseCase: SaveMovieUseCase
    private var fetchSavedMoviesUseCase: FetchMoviesUseCase
    private var toggleFavoriteUseCase: ToggleFavoritesUseCase
    
    var currentPage = 1
    @Published var isLoading: Bool = false
    
    init(searchMovieUseCase: SearchMovieUseCases,
         saveMovieUseCase: SaveMovieUseCase,
         fetchMoviesUseCase: FetchMoviesUseCase,
         toggleFavoriteUseCase: ToggleFavoritesUseCase
    ) {
        self.searchMovieUseCase = searchMovieUseCase
        self.saveMovieUseCase = saveMovieUseCase
        self.fetchSavedMoviesUseCase = fetchMoviesUseCase
        self.toggleFavoriteUseCase = toggleFavoriteUseCase
    }
    
    func searchMovies() async {
        guard !isLoading else { return }
        
        isLoading = true
        
        // executes when the function is done
        defer {
            isLoading = false
        }
        
        do {
            let movieSearchRequest = MovieSearchRequest(query: searchQuery,includeAdult: false,
                                                        language: "en-US", page: currentPage)
            
            let newMovies = try await searchMovieUseCase.execute(movieSearchRequest: movieSearchRequest)
            movies.append(contentsOf: newMovies)
            currentPage += 1
        } catch let error as NetworkError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
    
    func resetPage() {
        currentPage = 1
        movies.removeAll()
    }
    
    func saveMovie(movie: Movie) {
        do {
            try saveMovieUseCase.execute(movie: movie)
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
    
    func fetchStoredMovies() {
        do {
            storedMovies = try fetchSavedMoviesUseCase.execute()
            print(storedMovies)
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
    
    func toggleFavoriteMovies(movie: Movie) {
        guard let index = storedMovies.firstIndex(where: { $0.id == movie.id }) else { return }
        storedMovies[index].isFavorite.toggle()
        do {
            try toggleFavoriteUseCase.execute(movie: movie)
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
    
    func toggleSearchedFavoriteMovies(movie: Movie) {
        guard let index = movies.firstIndex(where: { $0.id == movie.id }) else { return }
        movies[index].isFavorite.toggle()
        do {
            try toggleFavoriteUseCase.execute(movie: movie)
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
}
