//
//  HomeViewModel.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//
import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {

    @Published var selectedDate: Date = .now
    @Published var isLoading = false
    @Published var apod: APOD? = nil
    @Published var errorMessage: String? = nil
    @Published var isFavourite = false

    func load() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            try await Task.sleep(for: .seconds(2))
            apod = .mock
        } catch {
            errorMessage = "Failed to load APOD"
        }
    }

    func toggleFavourite() {
        isFavourite.toggle()
    }

    

}
