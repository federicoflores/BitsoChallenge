//
//  NetworkProvider.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit
import Combine

class NetworkProvider {
    
    enum Path {
        case allArtworks
        case detailArtwork
        
        func setPath(with argument: String = "") -> String {
            switch self {
            case .allArtworks:
                return "/api/v1/artworks"
            case .detailArtwork:
                return "/api/v1/artworks/" + argument
            }
        }
    }
    
    enum Query {
        case allArtworks
        case detailArtworks
        
    }
    
    
    private var cancellable = Set<AnyCancellable>()
    let sessionConfig = URLSessionConfiguration.default
    
    func getDecodable<T: Decodable>(path: Path, page: Int = 1, completion: @escaping (Result<T, Error>) -> Void) {
        
        //let queryItems = [URLQueryItem(name: "fields", value: "id,title,artist_display,date_display,main_reference_number"), URLQueryItem(name: "page", value: "\(page)")]
        
        let queryItems = [URLQueryItem(name: "fields", value: "id,title,artist_display,date_display,main_reference_number"), URLQueryItem(name: "page", value: "\(page)")]

        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.artic.edu"
        components.path = path.setPath()
        
        components.queryItems = queryItems
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .sink { resultCompletion in
                switch resultCompletion {
                case .finished:
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            } receiveValue: { value in
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
}
