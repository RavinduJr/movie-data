//
//  URLRequest+Curl.swift
//  movie-data
//
//  Created by Ravindu Jayasekara on 5/23/26.
//

import Foundation

extension URLRequest {

    var curlString: String {

        guard let url = url else {
            return ""
        }

        var components = ["curl -v"]

        components.append("-X \(httpMethod ?? "GET")")

        for (key, value) in allHTTPHeaderFields ?? [:] {
            components.append("-H '\(key): \(value)'")
        }

        if let httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {

            components.append("-d '\(bodyString)'")
        }

        components.append("'\(url.absoluteString)'")

        return components.joined(separator: " \\\n\t")
    }
}
