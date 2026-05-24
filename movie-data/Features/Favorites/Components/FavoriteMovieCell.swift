//
//  FavoriteMovieCell.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI

struct FavoriteMovieCell: View {
    let movie: Movie
    
    let addToFavorites: (Movie) -> Void
    
    init (movie: Movie, addToFavorites: @escaping (Movie) -> Void) {
        self.movie = movie
        self.addToFavorites = addToFavorites
    }
    var body: some View {
        VStack {
            HStack {
                AsyncImage(
                    url: URL(string: "\(APIConstants.baseImageUrl)\(movie.posterPath ?? "")?t=\(Date().timeIntervalSince1970)")) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                ProgressView()
                                    .scaleEffect(0.5)
                            }
                            .frame(maxWidth: 60, maxHeight: 60)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 60, maxHeight: 60)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        case .failure:
                            ZStack {
                                Image(systemName: "film")
                                    .font(.system(size: 30))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: 60, maxHeight: 60)
                        @unknown default:
                            ZStack {
                                Image(systemName: "film")
                                    .font(.system(size: 30))
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: 60, maxHeight: 60)
                        }
                    }
                VStack(alignment: .leading, spacing: 5) {
                    Text(movie.title)
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .semibold))
                    Text(movie.releaseYear)
                        .font(.system(size: 12, weight: .light))
                }
                Spacer()
                HStack {
                    Image(systemName: movie.isFavorite ? "heart.fill" : "heart")
                        .frame(width: 30, height: 30)
                }
                .frame(maxWidth: 50, maxHeight: 50)
                .onTapGesture {
                    addToFavorites(self.movie)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .frame(maxWidth: .infinity, minHeight: 60)
    }
}
