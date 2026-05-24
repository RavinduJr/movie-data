//
//  FavoritesViewModel.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import SwiftUI
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [Movie] = []
    @Published var errorMessage: String? = nil
    @Published var showError: Bool = false
    
    let toggleFavoitesUseCase: ToggleFavoritesUseCase
    let fetchFavoitesUseCase: FetchFavoritesUseCase
    
    init(toggleFavoitesUseCase: ToggleFavoritesUseCase, fetchFavoitesUseCase: FetchFavoritesUseCase) {
        self.toggleFavoitesUseCase = toggleFavoitesUseCase
        self.fetchFavoitesUseCase = fetchFavoitesUseCase
    }
    
    func toggleFavorite(movie: Movie) {
        do {
            try self.toggleFavoitesUseCase.execute(movie: movie)
            fetchFavorites()
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
    
    func fetchFavorites() {
        do {
            favoriteMovies = try self.fetchFavoitesUseCase.execute()
            print(favoriteMovies)
        } catch let error as PersistenceError {
            errorMessage = error.errorDescription
            showError = true
        } catch {
            errorMessage = "Something went wrong"
            showError = true
        }
    }
}
