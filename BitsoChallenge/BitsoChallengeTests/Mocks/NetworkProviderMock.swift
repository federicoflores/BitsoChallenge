//
//  BaseProviderMock.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import BitsoChallenge

class NetworkProviderMock: NetworkProviderProtocol {
    
    func getDecodable<T>(path: BitsoChallenge.NetworkProvider.Path, query: BitsoChallenge.NetworkProvider.QueryFields, page: Int?, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
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
    
    func getData(path: BitsoChallenge.NetworkProvider.Path, completion: @escaping (Result<Data, Error>) -> Void) {}
    
}

