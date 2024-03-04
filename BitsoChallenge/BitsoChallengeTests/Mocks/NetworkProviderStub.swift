//
//  BaseProviderMock.swift
//  MuseumArtworksTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import MuseumArtworks

class NetworkProviderStub: NetworkProviderProtocol {
    
    func getDecodable<T>(path: MuseumArtworks.NetworkProvider.Path, query: MuseumArtworks.NetworkProvider.QueryFields, page: Int?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        var model: Decodable?
        
        switch path {
        case .allArtworks:
            model = JSONLoader().artworkListResponse()
        case .detailArtwork(artoworkID: "1"):
            model = JSONLoader().artworkDetailResponse()
        default:
            break
        }
        
        switch page {
        case 1:
            completion(.success(model as! T))
        case 0:
            completion(.failure(NSError(domain: "Test error", code: 404)))
        default:
            completion(.success(model as! T))
        }
    }
    
    func getData(path: MuseumArtworks.NetworkProvider.Path, completion: @escaping (Result<Data, Error>) -> Void) {}
    
}

