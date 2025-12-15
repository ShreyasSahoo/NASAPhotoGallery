//
//  APODGridCell.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 16/12/25.
//


import SwiftUI

struct APODGridCell: View {

    let apod: APOD

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            if apod.hasDisplayableMedia,
               let url = URL(string: apod.displayImageURL) {

                CustomAsyncImageView(
                    url: url,
                    height: 120,
                    cornerRadius: 12
                )
            } else {
                MissingMediaView(height: 120)
            }

            Text(apod.title)
                .font(.caption)
                .lineLimit(2)

            Text(apod.date)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}
