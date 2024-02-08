//
//  ArtworkDetailViewModel.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import Foundation
import UIKit

class ArtworkDetailViewModel: ObservableObject {
    
    enum ArtworkDetailState {
        case loading
        case success
        case error
    }
    
    var artwork: ArtoworkDetailResponse? {
        didSet {
            retrieveImage()
        }
    }
    
    var image: UIImage?
    
    @Published var artworkDetailState: ArtworkDetailState = .loading
    
    private let provider: NetworkProvider
    let id: Int
    
    init(provider: NetworkProvider, id: Int) {
        self.provider = provider
        self.id = id
        retrieveData(id: id)
    }
    
    func retrieveData(id: Int) {
        provider.getDecodable(path: .detailArtwork(artoworkID: "\(id)"), query: .detailArtworks) { [weak self] (result: Result<ArtoworkDetailResponse, Error>) in
            switch result {
            case .success(let artwork):
                self?.artwork = artwork
            case .failure(let error):
                self?.artworkDetailState = .error
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
                self?.artworkDetailState = .error
            }
        }
    }
}
