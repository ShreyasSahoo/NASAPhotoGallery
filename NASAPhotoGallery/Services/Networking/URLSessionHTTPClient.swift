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

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        return data
    }
}
