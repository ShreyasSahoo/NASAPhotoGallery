//
//  ErrorView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct ErrorView: View {

    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {

            Image(systemName: "wifi.exclamationmark")
                .font(.system(size: 40))
                .foregroundColor(.secondary)

            Text("Something went wrong")
                .font(.headline)
                .foregroundColor(Theme.primaryText)

            Text(message)
                .font(.subheadline)
                .foregroundColor(Theme.secondaryText)
                .multilineTextAlignment(.center)

            Button(action: retryAction) {
                Text("Retry")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                    .background(Theme.accent)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
