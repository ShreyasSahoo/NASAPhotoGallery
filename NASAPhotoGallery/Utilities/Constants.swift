//
//  Constants.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import Foundation

struct Constants {
    static let baseURL = "https://api.nasa.gov/planetary/apod"
    static let earliestDate: Date = Calendar.current.date(
        from: DateComponents(year: 1995, month: 6, day: 16)
    )!
}
