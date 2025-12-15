//
//  HomeViewModel.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    @Published var selectedDate: Date = .now
    @Published var isLoading = false
    @Published var apod: APOD? = nil
    @Published var errorMessage: String? = nil
    @Published var isFavourite = false

    private let service: APODService

    init(service: APODService = ProductionAPODService()) {
        self.service = service
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            apod = try await service.getAPOD(for: selectedDate)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func toggleFavourite() {
        isFavourite.toggle()
    }

    

}
