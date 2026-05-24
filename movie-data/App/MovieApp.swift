//
//  MovieApp.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI

@main
struct MovieApp: App {
    @StateObject private var router = AppRouter()
    let appContainer = AppContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SearchMoviesView(viewModel: appContainer.searchMovieViewModel).navigationDestination(for: Route.self) { route in
                    switch route {
                    case .movieDetails(let movie):
                        MovieDetailsView(movie: movie)
                    case .favorites:
                        FavoritesView(viewModel: appContainer.favoritesViewModel)
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
