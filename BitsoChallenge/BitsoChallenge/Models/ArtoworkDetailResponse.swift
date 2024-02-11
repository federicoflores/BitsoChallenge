//
//  ArtoworkDetailResponse.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation

struct ArtoworkDetailResponse: Decodable {
    var result: Artwork
    
    enum CodingKeys: String, CodingKey {
        case result = "data"
    }
}
