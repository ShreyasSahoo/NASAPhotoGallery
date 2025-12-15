//
//  NetworkError.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingFailed:
            return "Failed to decode response"
        case .serverError(let code):
            return "Server error (\(code))"
        }
    }
}
