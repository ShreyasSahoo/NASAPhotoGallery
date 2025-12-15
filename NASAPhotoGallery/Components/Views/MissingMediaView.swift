//
//  MissingMediaView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 16/12/25.
//

import SwiftUI

struct MissingMediaView: View {
    var height: CGFloat = 250
    var backgroundColor: Color = Theme.cardBackground
    var body: some View {
            VStack(spacing: 12) {
                Image(systemName: "livephoto.slash")
                    .font(.largeTitle)
                Text("Media unavailable")
                    .font(.headline)
            }
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
        }
}

