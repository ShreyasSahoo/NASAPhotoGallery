//
//  APODModel.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import Foundation

struct APOD: Codable, Hashable, Identifiable {

    let date: String
    let title: String
    let explanation: String
    let url: String
    let hdurl: String?
    let mediaType: MediaType
    let serviceVersion: String
    let thumbnailURL: String?

    var id: String { date }

    var displayImageURL: String {
        switch mediaType {
        case .image:
            return hdurl ?? url
        case .video:
            // put a missing image for optional thumbnail
            return thumbnailURL ?? url
        }
    }

    var hasDisplayableMedia: Bool {
        mediaType == .image && !url.isEmpty
    }


    init(
        date: String,
        title: String,
        explanation: String,
        url: String,
        hdurl: String? = nil,
        mediaType: MediaType,
        serviceVersion: String,
        thumbnailURL: String? = nil
    ) {
        self.date = date
        self.title = title
        self.explanation = explanation
        self.url = url
        self.hdurl = hdurl
        self.mediaType = mediaType
        self.serviceVersion = serviceVersion
        self.thumbnailURL = thumbnailURL
    }

    enum CodingKeys: String, CodingKey {
        case date
        case title
        case explanation
        case url
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case thumbnailURL = "thumbnail_url"
    }

    enum MediaType: String, Codable {
        case image
        case video
    }
}

extension APOD {
    static let mockImage = APOD(
        date: "2024-01-15",
        title: "Star Cluster IC 348 from Webb",
        explanation: """
        Sometimes, it's the stars that are the hardest to see that are the most interesting.
        The surrounding region contains young planet-mass brown dwarfs that float free,
        not orbiting any other star.
        """,
        url: "https://apod.nasa.gov/apod/image/2401/IC348_webb_960.jpg",
        hdurl: "https://apod.nasa.gov/apod/image/2401/IC348_webb_3788.jpg",
        mediaType: .image,
        serviceVersion: "v1",
    )

    static let mockVideo = APOD(
        date: "2024-01-15",
        title: "Juno Flyby of Ganymede and Jupiter",
        explanation: """
        Sometimes, it's the stars that are the hardest to see that are the most interesting.
        The surrounding region contains young planet-mass brown dwarfs that float free,
        not orbiting any other star.
        """,
        url: "https://www.youtube.com/embed/CC7OJ7gFLvE?rel=0",
        mediaType: .video,
        serviceVersion: "v1",
        thumbnailURL: "https://img.youtube.com/vi/CC7OJ7gFLvE/0.jpg"
    )
}
