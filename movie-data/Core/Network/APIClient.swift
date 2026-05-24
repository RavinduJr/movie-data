//
//  APIHeaders.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

protocol APIClient {
    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T
}
