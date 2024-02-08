//
//  HomeInteractor.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomeInteractorProtocols: AnyObject {
    var provider: NetworkProvider { get }
    func retrieveArtworks(page: Int)
}

class HomeInteractor: HomeInteractorProtocols {
    
    weak var homePresenter: HomePresenterProtocols?
    
    var provider = NetworkProvider()
    
    func retrieveArtworks(page: Int) {
        provider.getDecodable(path: NetworkProvider.Path.allArtworks, query: .allArtworks, page: page) { [weak self] (result: Result<ArtworkListResponse, Error>) in
            switch result {
            case .success(let response):
                self?.homePresenter?.onFetchPiecesOfArtSuccess(response: response)
            case .failure(let error):
                self?.homePresenter?.onFetchPiecesOfArtFail(error: error.localizedDescription)
            }
        }
    }
}
