//
//  AsyncImageView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct AsyncImageView: View {

    var url: URL = URL(string: APOD.mockImage.displayImageURL)!
    var height: CGFloat = 250
    var cornerRadius: CGFloat = 16

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Theme.cardBackground)
                    .frame(height: height)
                    .shimmer()
                    .overlay {
                        ProgressView()
                            .scaleEffect(2)
                    }
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: height)
                    .clipped()
            case .failure:
                // failure image
                Color.gray.frame(height: height)
            @unknown default:
                EmptyView()
            }
        }
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    VStack {
        AsyncImageView()

        AsyncImageView(url: URL(string: APOD.mockVideo.displayImageURL)!)

        AsyncImageView(height: 100, cornerRadius: 8)

        // Failure Case
        AsyncImageView(url: URL(string: "https://via.placeholder.com/150")!)
    }
    .padding()
}
