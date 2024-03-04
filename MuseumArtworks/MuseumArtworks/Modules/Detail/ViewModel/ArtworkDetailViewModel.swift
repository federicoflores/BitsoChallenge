//
//  ArtworkDetailViewModel.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 08/02/2024.
//

import Foundation
import UIKit

protocol ArtworkDetailViewModelProtocl {
    var artwork: ArtoworkDetailResponse? { get }
    func retrieveArtoworkDetail(id: Int)
    func retrieveImage()
}

class ArtworkDetailViewModel: ObservableObject, ArtworkDetailViewModelProtocl {
    
    enum ArtworkDetailState {
        case loading
        case success
        case error(error: String)
    }
    
    var artwork: ArtoworkDetailResponse? {
        didSet {
            retrieveImage()
        }
    }
    
    var image: UIImage?
    
    @Published var artworkDetailState: ArtworkDetailState = .loading
    
    private let provider: NetworkProviderProtocol
    let id: Int
    
    init(provider: NetworkProviderProtocol, id: Int) {
        self.provider = provider
        self.id = id
        retrieveArtoworkDetail(id: id)
    }
    
    func retrieveArtoworkDetail(id: Int) {
        provider.getDecodable(path: .detailArtwork(artoworkID: "\(id)"), query: .detailArtworks, page: nil) { [weak self] (result: Result<ArtoworkDetailResponse, Error>) in
            switch result {
            case .success(let artwork):
                self?.artwork = artwork
            case .failure(let error):
                self?.artworkDetailState = .error(error: error.localizedDescription)
            }
        }
    }
    
    func retrieveImage() {
        guard let imageID = artwork?.result.imageId else {
            artworkDetailState = .success
            return
        }
        
        provider.getData(path: .image(imageID: imageID)) { [weak self] (result:Result<Data, Error>) in
            switch result {
            case .success(let data):
                self?.image = UIImage(data: data)
                self?.artworkDetailState = .success
            case .failure(let error):
                self?.artworkDetailState = .error(error: error.localizedDescription)
            }
        }
    }
}
