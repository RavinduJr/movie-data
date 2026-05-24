//
//  URLSessionAPIClient.swift
//  movie-data
//
//  Created by Ravindu on 5/23/26.
//

import Foundation

final class URLSessionAPIClient: APIClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard var components = URLComponents(string: "\(endpoint.baseUrl)/\(endpoint.path)") else {
            throw NetworkError.invalidURL
        }
        
        components.queryItems = endpoint.queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = endpoint.method.rawValue
        
        if let httpBody = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(httpBody)
        }

        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(APIConstants.apiAccessToken)", forHTTPHeaderField: "Authorization")
        
        print(request.curlString)
        
        let (data, response) = try await self.session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
