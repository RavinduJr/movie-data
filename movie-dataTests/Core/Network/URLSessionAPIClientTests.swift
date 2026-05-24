//
//  URLSessionAPIClientTests.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import XCTest
@testable import movie_data

final class URLSessionAPIClientTests: XCTestCase {

    private var sut: URLSessionAPIClient!

    override func setUp() {
        super.setUp()

        let configuration = URLSessionConfiguration.ephemeral

        configuration.protocolClasses = [
            MockURLProtocol.self
        ]

        let session = URLSession(configuration: configuration)

        sut = URLSessionAPIClient(session: session)
    }

    override func tearDown() {
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubResponse = nil
        MockURLProtocol.stubError = nil

        sut = nil

        super.tearDown()
    }
    
    func test_request_decodesResponseSuccessfully() async throws {

        // GIVEN
        let json = """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/backdrop.jpg",
              "genre_ids": [1, 2],
              "id": 1,
              "title": "Batman Begins",
              "original_language": "en",
              "original_title": "Batman Begins",
              "overview": "Bruce Wayne becomes Batman",
              "popularity": 100.0,
              "poster_path": "/batman.jpg",
              "release_date": "2005-06-15",
              "softcore": false,
              "video": false,
              "vote_average": 8.2,
              "vote_count": 1000
            }
          ],
          "total_pages": 1,
          "total_results": 1
        }
        """

        MockURLProtocol.stubResponseData = json.data(using: .utf8)

        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let endpoint = MovieEndpoint.searchMovies(
            movieSearchRequest: MovieSearchRequest(
                query: "Batman",
                includeAdult: false,
                language: "en-US",
                page: 1
            )
        )

        // WHEN
        let response: MovieSearchResponse = try await sut.request(
            endpoint: endpoint
        )

        // THEN
        XCTAssertEqual(response.results.count, 1)
        XCTAssertEqual(response.results.first?.title, "Batman Begins")
    }
    
    func test_request_throwsServerError_whenStatusCodeIsInvalid() async {

        // GIVEN
        MockURLProtocol.stubResponseData = Data()

        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )

        let endpoint = MovieEndpoint.searchMovies(
            movieSearchRequest: MovieSearchRequest(
                query: "Batman",
                includeAdult: false,
                language: "en-US",
                page: 1
            )
        )

        // WHEN / THEN
        do {
            let _: MovieSearchResponse = try await sut.request(
                endpoint: endpoint
            )

            XCTFail("Expected server error")

        } catch {
            guard case NetworkError.serverError(let code) = error else {
                XCTFail("Expected server error")
                return
            }

            XCTAssertEqual(code, 500)
        }
    }
    
    func test_request_throwsDecodingError_whenJSONIsInvalid() async {

        // GIVEN
        let invalidJSON = """
        {
            "invalid_json": true
        }
        """

        MockURLProtocol.stubResponseData = invalidJSON.data(using: .utf8)

        MockURLProtocol.stubResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let endpoint = MovieEndpoint.searchMovies(
            movieSearchRequest: MovieSearchRequest(
                query: "Batman",
                includeAdult: false,
                language: "en-US",
                page: 1
            )
        )

        // WHEN / THEN
        do {
            let _: MovieSearchResponse = try await sut.request(
                endpoint: endpoint
            )

            XCTFail("Expected decoding error")

        } catch {
            XCTAssertEqual(
                error as? NetworkError,
                .decodingError
            )
        }
    }
    
    func test_request_throwsInvalidResponse_whenResponseIsNotHTTPURLResponse() async {

        // GIVEN
        MockURLProtocol.stubResponseData = Data()

        MockURLProtocol.stubResponse = URLResponse()

        let endpoint = MovieEndpoint.searchMovies(
            movieSearchRequest: MovieSearchRequest(
                query: "Batman",
                includeAdult: false,
                language: "en-US",
                page: 1
            )
        )

        // WHEN / THEN
        do {
            let _: MovieSearchResponse = try await sut.request(
                endpoint: endpoint
            )

            XCTFail("Expected invalid response")

        } catch {
            XCTAssertEqual(
                error as? NetworkError,
                .invalidResponse
            )
        }
    }
}
