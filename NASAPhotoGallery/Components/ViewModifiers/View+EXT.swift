//
//  View+EXT.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//
import SwiftUI

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
