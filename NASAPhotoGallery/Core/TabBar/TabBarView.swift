//
//  TabBarView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            FavouritesView()
            .tabItem {
                Label("Favourites", systemImage: "heart.fill")
            }

            HomeView()
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            SearchView()
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

#Preview {
    TabBarView()
}
