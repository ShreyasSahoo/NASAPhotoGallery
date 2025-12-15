//
//  APODEndpoint.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import Foundation

enum APODEndpoint {
    case today
    case date(Date)

    func makeRequest() throws -> URLRequest {
        guard var components = URLComponents(string: Constants.baseURL) else {
            throw NetworkError.invalidURL
        }

        var queryItems = [
            URLQueryItem(name: "api_key", value: Secrets.nasaApiKey),
            URLQueryItem(name: "thumbs", value: "true")
        ]

        switch self {
        case .today:
            break

        case .date(let date):
            queryItems.append(
                URLQueryItem(
                    name: "date",
                    value: date.formatted(.iso8601.year().month().day())
                )
            )
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        return URLRequest(url: url)
    }
}
