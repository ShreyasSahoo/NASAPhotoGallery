//
//  APODServiceImpl.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import Foundation

final class ProductionAPODService: APODService {

    private let api: APODAPI

    init(api: APODAPI = APODAPI()) {
        self.api = api
    }

    func getAPOD(for date: Date) async throws -> APOD {
        let endpoint: APODEndpoint = Calendar.current.isDateInToday(date) ? .today : .date(date)
        return try await api.fetch(endpoint: endpoint)
    }
}
