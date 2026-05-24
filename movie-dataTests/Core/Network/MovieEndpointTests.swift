//
//  MovieEndpointTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class MovieEndpointTests: XCTestCase {

    func test_searchMovies_endpointBuildsCorrectly() {

        // GIVEN
        let request = MovieSearchRequest(
            query: "Batman",
            includeAdult: false,
            language: "en-US",
            page: 1
        )

        // WHEN
        let endpoint = MovieEndpoint.searchMovies(
            movieSearchRequest: request
        )

        // THEN
        XCTAssertEqual(endpoint.path, "search/movie")
        XCTAssertEqual(endpoint.method, .get)

        XCTAssertTrue(
            endpoint.queryItems.contains {
                $0.name == "query" &&
                $0.value == "Batman"
            }
        )
    }
}
