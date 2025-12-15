//
//  APODService.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import Foundation

protocol APODService {
    func getAPOD(for date: Date) async throws -> APOD
}
