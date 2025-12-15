//
//  SearchViewModel.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 16/12/25.
//


import SwiftUI
import Combine

@MainActor
final class SearchViewModel: ObservableObject {

    @Published var startDate: Date = Calendar.current.date(byAdding: .day, value: -7, to: .now)!
    @Published var endDate: Date = .now

    @Published var isLoading = false
    @Published var apods: [APOD] = []
    @Published var errorMessage: String?

    private let service: APODService

    init(service: APODService = ProductionAPODService()) {
        self.service = service
    }

    func search() async {
        errorMessage = nil
        apods = []

        guard startDate <= endDate else {
            errorMessage = "Start date must be before end date."
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await service.getAPODs(from: startDate, to: endDate)
            apods = result.sorted { $0.date < $1.date }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
