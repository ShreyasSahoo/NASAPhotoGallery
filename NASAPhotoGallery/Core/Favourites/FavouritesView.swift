//
//  FavouritesView.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import SwiftUI

struct FavouritesView: View {

    @Environment(\.modelContext) private var context
    @State private var favourites: [APOD] = []

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]) {
                    ForEach(favourites) { apod in
                        APODGridCell(apod: apod)
                    }
                }
                .padding()
            }
            .navigationTitle("Favourites")
            .onAppear {
                favourites = FavouriteStore(context: context).fetchAll()
            }
        }
    }
}

#Preview {
    FavouritesView()
}
