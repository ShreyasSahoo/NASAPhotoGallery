//
//  NASAPhotoGalleryApp.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI
import SwiftData

@main
struct NASAPhotoGalleryApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
        .modelContainer(for: [FavouriteAPODEntity.self])
    }
}
