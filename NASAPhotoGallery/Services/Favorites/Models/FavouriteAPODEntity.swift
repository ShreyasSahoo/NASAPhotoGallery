//
//  FavouriteAPODEntity.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 16/12/25.
//

import Foundation
import SwiftData

@Model
final class FavouriteAPODEntity {

    @Attribute(.unique)
    var date: String

    var title: String
    var explanation: String
    var url: String
    var hdurl: String?
    var mediaType: String
    var serviceVersion: String
    var addedAt: Date

    init(from apod: APOD) {
        self.date = apod.date
        self.title = apod.title
        self.explanation = apod.explanation
        self.url = apod.url
        self.hdurl = apod.hdurl
        self.mediaType = apod.mediaType.rawValue
        self.serviceVersion = apod.serviceVersion
        self.addedAt = Date()
    }

    func toAPOD() -> APOD {
        APOD(
            date: date,
            title: title,
            explanation: explanation,
            url: url,
            hdurl: hdurl,
            mediaType: APOD.MediaType(rawValue: mediaType) ?? .image,
            serviceVersion: serviceVersion
        )
    }
}
