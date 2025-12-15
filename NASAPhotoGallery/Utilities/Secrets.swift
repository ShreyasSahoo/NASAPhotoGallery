//
//  Secrets.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//
import Foundation

enum Secrets {
    static var nasaApiKey: String {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "NASA_API_KEY"
        ) as? String else {
            fatalError("NASA_API_KEY missing")
        }
        return key
    }
}
