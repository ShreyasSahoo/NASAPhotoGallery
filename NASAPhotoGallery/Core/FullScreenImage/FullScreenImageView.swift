//
//  FullScreenImageView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct FullScreenImageView: View {

    var apod = APOD.mockVideo
    @State private var currentScale: CGFloat = 0
    @State private var lastScale: CGFloat = 0
    @State private var showInfo: Bool = false
    @State private var showShare: Bool = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                if let url = URL(string: apod.displayImageURL) {
                    CustomAsyncImageView(url: url, height: UIScreen.main.bounds.height)
                        .scaleEffect(CGFloat(1 + currentScale + lastScale))
                        .gesture(magnificationGesture)
                        .frame(width: UIScreen.main.bounds.width)
                        .overlay(alignment: .top) {
                            titleSection
                        }
                }
            }
        }
        .sheet(isPresented: $showInfo, content: {
            VStack {
                Text(apod.explanation)
            }
            .padding()

        })
        .overlay(alignment: .bottomTrailing) {
            bottomActionRow
        }
        .ignoresSafeArea()
        .padding()
    }

    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(apod.title)
                .font(.title2)
                .foregroundStyle(.white)
                .bold()

            Text(apod.date)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding(.top, 64)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                )
        }
    }

    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                currentScale = value - 1
            }
            .onEnded { _ in
                lastScale += currentScale
                currentScale = 0
            }
    }

    private var bottomActionRow: some View {
        HStack {
            Button {
                showInfo = true
            } label: {
                Image(systemName: "info.circle.fill")
                    .font(.title)
                    .foregroundStyle(.secondaryText)
            }

            Spacer()

            Button {
                showShare = true
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.title)
                    .foregroundStyle(.secondaryText)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 40)
        .padding(.horizontal, 24)
    }
}

#Preview {
    FullScreenImageView()
}
