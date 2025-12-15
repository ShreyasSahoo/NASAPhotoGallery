//
//  ShimmerModifier.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//


import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var isActive = false

    func body(content: Content) -> some View {
        content
            .opacity(isActive ? 0.5 : 1.0)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 0.9)
                        .repeatForever(autoreverses: true)
                ) {
                    isActive = true
                }
            }
    }
}