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
    case range(start: Date, end: Date)

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
                    value: Self.dateFormatter.string(from: date)
                )
            )
        case .range(let start, let end):
            let startDate = Self.dateFormatter.string(from: start)
            let endDate = Self.dateFormatter.string(from: end)

            queryItems.append(
                URLQueryItem(name: "start_date", value: startDate)
            )
            queryItems.append(
                URLQueryItem(name: "end_date", value: endDate)
            )
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        return URLRequest(url: url)
    }

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_IN")
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")!
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}
