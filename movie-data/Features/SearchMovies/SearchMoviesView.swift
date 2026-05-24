//
//  SearchMovies.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI

struct SearchMoviesView: View {
    @StateObject var viewModel: SearchMoviesViewModel
    @EnvironmentObject private var router: AppRouter
    @FocusState private var isSearchFocused: Bool

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("search_movies").font(.system(size: 30, weight: .bold))
                    Spacer()
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            router.push(.favorites)
                        }
                }
                HStack(alignment: .center) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("search_placeholder")
                        .font(.system(size: 15, weight: .regular))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                )
                .onTapGesture {
                    isSearchFocused = true
                    viewModel.searchQuery = ""
                    viewModel.showSearch = true
                }
                ScrollView {
                    ForEach(viewModel.storedMovies) { movie in
                        FetchedMovieCell(movie: movie) { movie in
                            viewModel.toggleFavoriteMovies(movie: movie)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            router.push(.movieDetails(movie))
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //                .fullScreenCover(isPresented: $viewModel.showSearch) {
                //                    searchView
                //                }
                .onChange(of: viewModel.showSearch) {value in
                    if !value {
                        if let movie = viewModel.selectedMovie {
                            router.push(.movieDetails(movie))
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(Color.gray.opacity(0.1))
            .onAppear() {
                viewModel.fetchStoredMovies()
            }
            
            if viewModel.showSearch {
                searchView
                    .zIndex(1)
            }
            
            if viewModel.isLoading {
                ZStack {
                    VStack {
                        Color.clear
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack {
                        ProgressView()
                    }
                    .frame(maxWidth: 50, maxHeight: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.5))
                    )
                }
                .zIndex(2)
            }
        }
    }
}

extension SearchMoviesView {
    
    var searchView: some View {
            VStack {
                HStack {
                    TextField("", text: $viewModel.searchQuery,
                              prompt: Text("search_placeholder").foregroundStyle(.white))
                        .foregroundStyle(.white)
                        .font(.system(size: 15, weight: .regular))
                        .padding(.all, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                        )
                        .focused($isSearchFocused)
                        .submitLabel(.search)
                        .onSubmit {
                            viewModel.resetPage()
                            isSearchFocused = false
                            Task {
                                await viewModel.searchMovies()
                            }
                        }
                    Button("cancel") {
                        viewModel.selectedMovie = nil
                        viewModel.movies.removeAll()
                        viewModel.showSearch = false
                        viewModel.fetchStoredMovies()
                    }
                    .foregroundStyle(.white)
                    .font(.system(size: 12, weight: .semibold))
                    
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .background(Color.gray.opacity(0.5))
                if !viewModel.searchQuery.isEmpty, viewModel.movies.isEmpty, !viewModel.isLoading {
                    ZStack {
                        Color.clear
                        HStack {
                            Text("press")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundStyle(.gray)
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        if viewModel.movies.isEmpty && viewModel.searchQuery.isEmpty {
                            Text("recent_searches")
                                .font(.system(size: 16, weight: .bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.storedMovies) { movie in
                                    FetchedMovieCell(movie: movie) { movie in
                                        viewModel.toggleFavoriteMovies(movie: movie)
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        viewModel.saveMovie(movie: movie)
                                        viewModel.selectedMovie = movie
                                        viewModel.movies.removeAll()
                                        viewModel.showSearch = false
                                    }
                                }
                            }
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.movies) { movie in
                                    SearchMovieCell(movie: movie) {movie in
                                        viewModel.toggleSearchedFavoriteMovies(movie: movie)
                                    }
                                    .contentShape(Rectangle())
                                    .onAppear {
                                        if movie.id == viewModel.movies.last?.id {
                                            Task {
                                                await viewModel.searchMovies()
                                            }
                                        }
                                    }
                                    .onTapGesture {
                                        viewModel.saveMovie(movie: movie)
                                        viewModel.selectedMovie = movie
                                        viewModel.movies.removeAll()
                                        viewModel.showSearch = false
                                    }
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal, 16)
                }
            }
            .background(Color.gray.opacity(0.1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
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
