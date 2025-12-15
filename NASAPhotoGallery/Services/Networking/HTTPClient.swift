//
//  HTTPClient.swift
//  NASAPhotoGallery
//
//  Created by Shreyas on 15/12/25.
//

import Foundation

protocol HTTPClient {
    func send(_ request: URLRequest) async throws -> Data
}
