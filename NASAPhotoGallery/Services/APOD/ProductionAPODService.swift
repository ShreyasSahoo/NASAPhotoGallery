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

    func getAPODs(from startDate: Date, to endDate: Date) async throws -> [APOD] {
        let endpoint = APODEndpoint.range(start: startDate, end: endDate)
        return try await api.fetchRange(endpoint: endpoint)
    }
}

struct APODAPIErrorResponse: Decodable {
    let error: APODAPIError

    struct APODAPIError: Decodable {
        let code: String
        let message: String
    }
}
