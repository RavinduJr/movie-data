//
//  MovieDetailsView.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    var image: String {
        "\(APIConstants.baseImageUrl)\(movie.posterPath ?? "")"
    }
    
    var body: some View {

        ZStack(alignment: .top) {

            backgroundImage

            content
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
    
    private var backgroundImage: some View {

        ZStack(alignment: .bottom) {

            AsyncImage(url: URL(string: "\(image)?t=\(Date().timeIntervalSince1970)"), content: {phase in
                switch phase {
                case .empty:
                    ZStack {
                        VStack {
                            ProgressView()
                        }
                        .frame(maxWidth: 50, maxHeight: 50)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .background(Color.gray.opacity(0.1))
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    VStack {
                        Text("Failed to load image")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                @unknown default:
                    VStack {
                        Text("Failed to load image")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                }
            })

            LinearGradient(
                colors: [
                    Color.clear,
                    Color.black.opacity(0.3),
                    Color.black.opacity(0.7),
                    Color.black
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 350)
        }
    }
    
    private var content: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                    .frame(height: 350)
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                Text(movie.releaseYear)
                Text(movie.overview)
            }
            .padding()
            .foregroundColor(.white)
        }
        .scrollIndicators(.hidden)
    }
}
