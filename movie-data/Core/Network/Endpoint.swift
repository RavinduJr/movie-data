//
//  Endpoint.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
    var body: Codable? { get }
}
