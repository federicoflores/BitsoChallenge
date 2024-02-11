//
//  Pagination.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation

struct Pagination: Codable {
    let currentPage: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
    }
}
