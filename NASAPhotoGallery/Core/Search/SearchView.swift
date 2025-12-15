//
//  SearchView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct SearchView: View {

    @StateObject private var viewModel = SearchViewModel()

    private let earliestDate = Constants.earliestDate
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                dateSelectors
                searchButton
                content
                Spacer()
            }
            .padding()
            .navigationTitle("Search APODs")
        }
    }

    private var dateSelectors: some View {
        VStack(spacing: 12) {

            DatePicker(
                "Start Date",
                selection: $viewModel.startDate,
                in: earliestDate...Date(),
                displayedComponents: .date
            )

            DatePicker(
                "End Date",
                selection: $viewModel.endDate,
                in: earliestDate...Date(),
                displayedComponents: .date
            )
        }
    }

    private var searchButton: some View {
        Button {
            Task { await viewModel.search() }
        } label: {
            Text("Search")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.accent)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView()
                .scaleEffect(1.5)
                .padding(.top)
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error) {
                Task { await viewModel.search() }
            }
        } else {
            apodGrid
        }
    }

    private var apodGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(viewModel.apods) { apod in
                    APODGridCell(apod: apod)
                }
            }
            .padding(.top)
        }
    }

}

#Preview {
    SearchView()
}
