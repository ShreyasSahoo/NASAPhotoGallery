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
    private var favouriteStore: FavouriteStore?

    init(service: APODService = ProductionAPODService()) {
        self.service = service
    }

    func configure(favouriteStore: FavouriteStore) {
        self.favouriteStore = favouriteStore
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let apod = try await service.getAPOD(for: selectedDate)
            self.apod = apod

            if let store = favouriteStore {
                isFavourite = store.isFavourite(date: apod.date)
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func toggleFavourite() {
        guard let apod, let store = favouriteStore else { return }
        isFavourite = store.toggle(apod)
    }
}
