//
//  FavouriteStore.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 16/12/25.
//

import Foundation
import SwiftData

@MainActor
final class FavouriteStore {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func isFavourite(date: String) -> Bool {
        let descriptor = FetchDescriptor<FavouriteAPODEntity>(
            predicate: #Predicate { $0.date == date }
        )

        let results = (try? context.fetch(descriptor)) ?? []
        return !results.isEmpty
    }

    func add(_ apod: APOD) {
        context.insert(FavouriteAPODEntity(from: apod))
        try? context.save()
    }

    func remove(date: String) {
        let descriptor = FetchDescriptor<FavouriteAPODEntity>(
            predicate: #Predicate { $0.date == date }
        )
        if let entity = try? context.fetch(descriptor).first {
            context.delete(entity)
            try? context.save()
        }
    }

    func toggle(_ apod: APOD) -> Bool {
        if isFavourite(date: apod.date) {
            remove(date: apod.date)
            return false
        } else {
            add(apod)
            return true
        }
    }

    func fetchAll() -> [APOD] {
        let descriptor = FetchDescriptor<FavouriteAPODEntity>(
            sortBy: [SortDescriptor(\.addedAt, order: .reverse)]
        )
        return (try? context.fetch(descriptor))?.map { $0.toAPOD() } ?? []
    }
}
