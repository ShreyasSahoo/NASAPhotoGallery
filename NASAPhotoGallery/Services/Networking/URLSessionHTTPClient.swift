//
//  URLSessionHTTPClient.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import Foundation

final class URLSessionHTTPClient: HTTPClient {

    func send(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200..<300:
            return data
        case 401:
            throw NetworkError.serverErrorMessage("Invalid API key.")
        case 429:
            throw NetworkError.serverErrorMessage("Too many requests. Please try again later.")
        case 500..<600:
            throw NetworkError.serverError(httpResponse.statusCode)
        default:
            throw NetworkError.invalidResponse
        }
    }
}
