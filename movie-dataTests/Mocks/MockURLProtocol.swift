//
//  MockURLProtocol.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/24/26.
//

import Foundation

final class MockURLProtocol: URLProtocol {

    static var stubResponseData: Data?
    static var stubResponse: URLResponse?
    static var stubError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {

        if let error = Self.stubError {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let response = Self.stubResponse {
            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
        }

        if let data = Self.stubResponseData {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() { }
}
