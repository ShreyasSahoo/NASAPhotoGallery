//
//  DescriptionCardView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct DescriptionCardView: View {

    var apod: APOD = .mockImage
    var cornerRadius: CGFloat = 10
    var backgroundColor: Color = Theme.cardBackground

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(apod.title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Theme.primaryText)

            Text(apod.date)
                .font(.caption)
                .foregroundColor(Theme.secondaryText)

            Divider()

            Text(apod.explanation)
                .font(.body)
                .foregroundColor(Theme.primaryText)
                .lineSpacing(4)

        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
}

#Preview {
    VStack {
        DescriptionCardView(apod: .mockVideo)
            .padding(.horizontal, 8)

        DescriptionCardView(cornerRadius: 24, backgroundColor: .yellow)
            .padding(.horizontal, 8)
    }
    .padding(8)
}
