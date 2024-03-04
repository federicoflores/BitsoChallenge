//
//  JSONLoader.swift
//  MuseumArtworksTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import MuseumArtworks

class JSONLoader {
    
    enum MockedResponses: String {
        case artworkListResponse = "artworkListResponse"
        case artworkDetailResponse = "artworkDetailResponse"
    }
    
    internal func artworkListResponse() -> ArtworkListResponse? {
        if let path = Bundle.main.path(forResource: MockedResponses.artworkListResponse.rawValue, ofType: "json") {
        do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let item = try? JSONDecoder().decode(ArtworkListResponse.self, from: data)
            return item
        } catch {
            print(error)
             }
        }
        return nil
    }
    
    internal func artworkDetailResponse() -> ArtoworkDetailResponse? {
        if let path = Bundle.main.path(forResource: MockedResponses.artworkDetailResponse.rawValue, ofType: "json") {
        do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let item = try? JSONDecoder().decode(ArtoworkDetailResponse.self, from: data)
            return item
        } catch {
            print(error)
             }
        }
        return nil
    }
    
}
