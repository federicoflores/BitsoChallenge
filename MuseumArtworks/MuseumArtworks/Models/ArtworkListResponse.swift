//
//  ArtworkListResponse.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

struct ArtworkListResponse: Codable {
    var results: [Artwork] = []
    var pagination: Pagination?
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
        case pagination = "pagination"
    }
}
