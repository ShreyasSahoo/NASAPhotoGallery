//
//  CustomAsyncImageView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct CustomAsyncImageView: View {

    let url: URL
    var height: CGFloat = 250
    var cornerRadius: CGFloat = 16

    @State private var image: UIImage?
    @State private var isLoading = false

    var body: some View {
        ZStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Theme.cardBackground)
                    .shimmer()
                    .overlay {
                        ProgressView().scaleEffect(2)
                    }
            }
        }
        .frame(height: height)
        .clipped()
        .cornerRadius(cornerRadius)
        .task {
            await loadImage()
        }
    }

    @MainActor
    private func loadImage() async {
        if let cached = ImageCache.shared.image(for: url) {
            print(url)
            image = cached
            return
        }

        guard !isLoading else { return }
        isLoading = true

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                ImageCache.shared.insert(uiImage, for: url)
                image = uiImage
            }
        } catch {
            // optional: error UI
        }
    }
}
