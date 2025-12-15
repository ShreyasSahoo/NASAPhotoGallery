//
//  LoadedHomeContent.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import SwiftUI

struct LoadedHomeContent: View {

    @Binding var isFavourite: Bool

    let apod: APOD
    let onFavouriteTap: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            // MARK: Image with Favourite Overlay
            if let url = URL(string: apod.imageURL) {
                AsyncImageView(url: url)
                    .overlay(alignment: .bottomTrailing) {
                        favouriteButton
                    }
            }

            // MARK: Description Card
            DescriptionCardView(apod: apod)
        }
    }

    private var favouriteButton: some View {
        Button {
            //TODO: Add favourite logic
            isFavourite.toggle()
        } label: {
            Image(systemName: isFavourite ? "heart.fill" : "heart")
                .font(.title2)
                .foregroundColor(Theme.favourite)
                .padding(8)
                .background(.black.opacity(0.2))
                .clipShape(Circle())
        }
        .padding(8)
    }
}
