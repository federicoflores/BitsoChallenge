//
//  NetworkProvider.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit
import Combine

class NetworkProvider {
    
    init() {
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 60.0
    }
    
    enum Path {
        case allArtworks
        case detailArtwork(artoworkID: String)
        case image(imageID: String)
        
        func setPath() -> String {
            switch self {
            case .allArtworks:
                return "/api/v1/artworks"
            case .detailArtwork(let artoworkID):
                return "/api/v1/artworks/" + artoworkID
            case .image(let imageID):
                return "/iiif/2/" + imageID + "/full/843,/0/default.jpg"
            }
        }
    }
    
    enum QueryFields {
        case allArtworks
        case detailArtworks
        
        func setQuery(page: Int)->  [URLQueryItem] {
            switch self {
            case .allArtworks:
                return [URLQueryItem(name: "fields", value: "id,title,artist_titles"), URLQueryItem(name: "page", value: "\(page)")]
            case .detailArtworks:
                return [URLQueryItem(name: "fields", value: "id,title,artist_display,date_display,main_reference_number,provenance_text,image_id,place_of_origin,dimensions,medium_display")]
            }
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    let sessionConfig = URLSessionConfiguration.default
    
    func getDecodable<T: Decodable>(path: Path, query: QueryFields, page: Int = 1, completion: @escaping (Result<T, Error>) -> Void) {
        
        let queryItems = query.setQuery(page: page)
        
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
    
    func getData(path: Path, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.artic.edu"
        components.path = path.setPath()
        
        
        guard let url = components.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession(configuration: sessionConfig)
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map { $0.data }
            .sink { resultCompletion in
                switch resultCompletion {
                case .finished:
                    return
                case .failure(let error):
                    self.cancelAllDownloads()
                    completion(.failure(error))
                }
            } receiveValue: { value in
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
    
    func cancelAllDownloads() {
        cancellable.removeAll()
    }

    
}
