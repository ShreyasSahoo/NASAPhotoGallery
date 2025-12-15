//
//  HomeView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init()

    @State private var showDatePicker = false

    private var isToday: Bool {
        Calendar.current.isDateInToday(viewModel.selectedDate)
    }

    var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    titleSection
                        .zIndex(1)
                    content
                        .zIndex(0)
                }
                .animation(.easeInOut, value: viewModel.isLoading)
            }
            .padding()
            .background(Theme.backgroundPrimary)
            .scrollIndicators(.hidden)
            .sheet(isPresented: $showDatePicker) {
                datePickerSheet
            }
            .task {
                guard viewModel.apod == nil else { return }
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            LoadingSkeletonView()
        } else if let apod = viewModel.apod {
            LoadedHomeContent(
                isFavourite: $viewModel.isFavourite, apod: apod) {
                    viewModel.toggleFavourite()
                }
        } else if let error = viewModel.errorMessage {
            ErrorView(message: error) {
                Task { await viewModel.load() }
            }
        } else {
            LoadingSkeletonView()
        }
    }

    private var titleSection: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 2) {
                Text("APOD")
                    .font(.caption)
                    .foregroundColor(Theme.secondaryText)

                Text(isToday
                     ? "Today"
                     : viewModel.selectedDate.formatted(
                        .dateTime.month(.wide).day().year()
                     )
                )
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Theme.primaryText)
            }

            Spacer()

            Button {
                showDatePicker = true
            } label: {
                Image(systemName: "calendar")
                    .font(.title)
                    .foregroundColor(Theme.accent)
            }
        }
    }

    private var datePickerSheet: some View {
        VStack(spacing: 16) {

            Text("Select Date")
                .font(.title2)

            DatePicker(
                "",
                selection: $viewModel.selectedDate,
                in: Constants.earliestDate...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)

            Button("Done") {

                defer {
                    showDatePicker = false
                }
                Task {
                    await viewModel.load()
                }
                // later → trigger ViewModel reload
            }
            .font(.headline)
            .padding(.bottom)
        }
        .padding()
        .presentationDetents([.fraction(0.75)])
    }

}

#Preview {
    NavigationStack {
        HomeView()
    }
}
