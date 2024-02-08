//
//  ArtworksResponse.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

struct ArtworkListResponse: Decodable {
    var results: [Artwork] = []
    
    enum CodingKeys: String, CodingKey {
        case results = "data"
    }
}

//TODO:: MOVE ACCORDING TO PROJECT STRUCTURE
struct ArtoworkDetailResponse: Decodable {
    var result: Artwork
    
    enum CodingKeys: String, CodingKey {
        case result = "data"
    }
}

struct Artwork: Decodable {
    let id: Int?
    let title: String?
    let artistDisplay: String?
    let artistTitles: [String]?
    let dateDisplay: String?
    let placeOfOrigin: String?
    let dimensions: String?
    let mediumDisplay: String?
    let provenanceText: String?
    let imageId: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, dimensions
        case artistDisplay = "artist_display"
        case artistTitles = "artist_titles"
        case dateDisplay = "date_display"
        case placeOfOrigin = "place_of_origin"
        case mediumDisplay = "medium_display"
        case provenanceText = "provenance_text"
        case imageId = "image_id"
    }
}


