//
//  NetworkProvider.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit
import Combine

class NetworkProvider {
    
    fileprivate enum Constant {
        static let sesionConfigTimeIntervals: CGFloat = 20.0
        static let fieldsKey: String = "fields"
        static let pageKey: String = "page"
        static let allArtworksFieldsValues = "id,title,artist_titles"
        static let detailArtworksFieldsValues = "id,title,artist_display,date_display,main_reference_number,provenance_text,image_id,place_of_origin,dimensions,medium_display"
        static let scheme: String = "https"
    }
    
    init() {
        sessionConfig.timeoutIntervalForRequest = Constant.sesionConfigTimeIntervals
        sessionConfig.timeoutIntervalForResource = Constant.sesionConfigTimeIntervals
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
                return [URLQueryItem(name: Constant.fieldsKey, value: Constant.allArtworksFieldsValues), URLQueryItem(name: Constant.pageKey, value: "\(page)")]
            case .detailArtworks:
                return [URLQueryItem(name: Constant.fieldsKey, value: Constant.detailArtworksFieldsValues)]
            }
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    let sessionConfig = URLSessionConfiguration.default
    let cacheManager = CacheManager.shared.cache
    
    func getDecodable<T: Decodable>(path: Path, query: QueryFields, page: Int = 1, completion: @escaping (Result<T, Error>) -> Void) {
        
        let queryItems = query.setQuery(page: page)
        
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = AppConfigurationManager.shared.getAppConfiguration(with: .API_BASE_HOST)
        components.path = path.setPath()
        
        components.queryItems = queryItems
        
        guard let url = components.url else { return }
        
        if let cached = cacheManager[url.absoluteString as NSString], let decodable = cached as? T {
            completion(.success(decodable))
            return
        }
                
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
            } receiveValue: {  value in
                self.cacheManager[url.absoluteString as NSString] = value
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
    
    func getData(path: Path, completion: @escaping (Result<Data, Error>) -> Void) {
        
        var components = URLComponents()
        components.scheme = Constant.scheme
        components.host = AppConfigurationManager.shared.getAppConfiguration(with: .API_IMAGE_HOST)
        components.path = path.setPath()
        
        guard let url = components.url else { return }
        
        if let cached = cacheManager[url.absoluteString as NSString], let data = cached as? Data {
            completion(.success(data))
            return
        }
        
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
                self.cacheManager[url.absoluteString as NSString] = value
                completion(.success(value))
            }
            .store(in: &cancellable)
    }
    
    func cancelAllDownloads() {
        cancellable.removeAll()
    }

    
}
