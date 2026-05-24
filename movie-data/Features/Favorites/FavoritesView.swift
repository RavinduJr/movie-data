//
//  FavoritesView.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    @EnvironmentObject private var router: AppRouter
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.favoriteMovies) { movie in
                FavoriteMovieCell(movie: movie) { movie in
                    viewModel.toggleFavorite(movie: movie)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    router.push(.movieDetails(movie))
                }
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchFavorites()
        }
        .navigationTitle("favorites")
        .alert(
            "Error",
            isPresented: $viewModel.showError
        ) {
            Button("OK", role: .cancel) {
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}
