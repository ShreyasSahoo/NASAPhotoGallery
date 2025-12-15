//
//  LoadingSkeletonView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct LoadingSkeletonView: View {

    var body: some View {
        VStack(spacing: 20) {

            // Image skeleton
            RoundedRectangle(cornerRadius: 18)
                .fill(Theme.cardBackground)
                .frame(height: 250)
                .overlay {
                    ProgressView()
                        .scaleEffect(2)
                }

            // Description card skeleton
            VStack(alignment: .leading, spacing: 12) {

                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.secondary.opacity(0.3))
                    .frame(width: 180, height: 20)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.secondary.opacity(0.25))
                    .frame(width: 100, height: 12)

                Divider()

                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.secondary.opacity(0.2))
                        .frame(height: 14)
                }
            }
            .padding()
            .background(Theme.cardBackground)
            .cornerRadius(18)
        }
        .shimmer()
    }
}


