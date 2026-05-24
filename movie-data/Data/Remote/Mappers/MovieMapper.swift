//
//  MovieMapper.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

extension MovieDTO {
    func toDomain() -> Movie {
        Movie(id: id,
              title: title,
              overview: overview,
              posterPath: posterPath,
              releaseDate: releaseDate,
              isFavorite: false
        )
    }
}
