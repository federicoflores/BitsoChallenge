//
//  ArtworksResponse.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

struct ArtworksResponse: Decodable {
    //let pagination: PaginationMetadata?
    var results: [Artwork] = []
    
    enum CodingKeys: String, CodingKey {
        //case pagination
        case results = "data"
    }
}

struct Artwork: Decodable {
    let id: Int?
    let title: String?
    let artistDisplay: String?
    let dateDisplay: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case artistDisplay = "artist_display"
        case dateDisplay = "date_display"
    }
}


//struct PaginationMetadata: Decodable {
//    let total: Int?
//    let limit: Int?
//    let offset: Int?
//    let totalPages: Int?
//    let currentPage: Int?
//    let previousUrl: String?
//    let nextUrl: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case total, limit, offset
//        case totalPages = "total_pages"
//        case currentPage = "current_page"
//        case previousUrl = "prev_url"
//        case nextUrl = "next_url"
//    }
//}
