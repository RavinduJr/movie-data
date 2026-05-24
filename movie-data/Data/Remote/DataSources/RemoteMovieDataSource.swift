//
//  RemoteMovieDataSource.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

final class RemoteMovieDataSource: RemoteMovieDataSourceProtocol {
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func searchMovies(movieSearchRequest: MovieSearchRequest) async throws -> [MovieDTO] {
        let response: MovieSearchResponse = try await self.apiClient.request(
            endpoint: MovieEndpoint.searchMovies(movieSearchRequest: movieSearchRequest))
        return response.results
    }
}
