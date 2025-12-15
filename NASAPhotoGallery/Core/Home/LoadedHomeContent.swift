//
//  LoadedHomeContent.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import SwiftUI

struct LoadedHomeContent: View {

    @ObservedObject var viewModel: HomeViewModel
    @State private var showFullScreenImage: Bool = false
    let apod: APOD

    var body: some View {
        VStack(spacing: 20) {

            // MARK: Image with Favourite Overlay
            if apod.hasDisplayableMedia,
               let url = URL(string: apod.displayImageURL) {
                CustomAsyncImageView(url: url)
                    .id(url)
                    .overlay(alignment: .bottomTrailing) {
                        favouriteButton
                    }
                    .onTapGesture {
                        showFullScreenImage = true
                    }
            } else {
                MissingMediaView()
            }

            // MARK: Description Card
            DescriptionCardView(
                title: apod.title,
                date: apod.date,
                explanation: apod.explanation
            )
        }
        .fullScreenCover(isPresented: $showFullScreenImage) {
            FullScreenImageView(apod: apod)
        }
    }

    private var favouriteButton: some View {
        Button {
            viewModel.toggleFavourite()
        } label: {
            Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                .font(.title2)
                .foregroundColor(Theme.favourite)
                .padding(8)
                .background(.black.opacity(0.2))
                .clipShape(Circle())
        }
        .padding(8)
    }
}
