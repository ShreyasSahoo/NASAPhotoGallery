//
//  DescriptionCardView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct DescriptionCardView: View {

    let title: String
    let date: String
    let explanation: String
    var cornerRadius: CGFloat = 10
    var backgroundColor: Color = Theme.cardBackground

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(Theme.primaryText)

            Text(date)
                .font(.caption)
                .foregroundColor(Theme.secondaryText)

            Divider()

            Text(explanation)
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

        DescriptionCardView(title: APOD.mockImage.title, date: APOD.mockImage.date, explanation: APOD.mockImage.explanation)
            .padding(.horizontal, 8)

        DescriptionCardView(title: APOD.mockVideo.title, date: APOD.mockVideo.date, explanation: APOD.mockVideo.explanation, cornerRadius: 24, backgroundColor: .yellow)
            .padding(.horizontal, 8)
    }
    .padding(8)
}
