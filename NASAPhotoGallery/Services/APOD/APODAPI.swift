//
//  APODAPI.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import Foundation

final class APODAPI {

    private let client: HTTPClient
    private let decoder: JSONDecoder

    init(
        client: HTTPClient = URLSessionHTTPClient(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.client = client
        self.decoder = decoder
    }

    func fetch(endpoint: APODEndpoint) async throws -> APOD {
        let request = try endpoint.makeRequest()
        let data = try await client.send(request)
        do {
            return try decoder.decode(APOD.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
