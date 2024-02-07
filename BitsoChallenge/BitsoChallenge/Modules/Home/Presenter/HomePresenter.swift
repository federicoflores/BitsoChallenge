//
//  HomePresenter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
    func onViewDidLoad(page: Int)
    func onFetchPiecesOfArtSuccess(response: ArtworksResponse)
    func onFetchPiecesOfArtFail(error: String)
    func numberOfItemsInSection(section: Int) -> Int
    func getArtworkViewModel(row: Int) -> ArtworkViewModel?
    func didScrollToBottom(row: Int) -> Bool
    func didSelectRow(row: Int)
}

class HomePresenter: HomePresenterProtocols {
    
    var artworkResponse: ArtworksResponse = ArtworksResponse(results: [])
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    func onViewDidLoad(page: Int) {
        homeView?.showLoadingView()
        homeInteractor?.retrieveArtworks(page: page)
    }
    
    func onFetchPiecesOfArtSuccess(response: ArtworksResponse) {
        homeView?.hideLoadingView()
        artworkResponse.results.append(contentsOf: response.results)
        homeView?.reloadCollectionView()
    }
    
    func onFetchPiecesOfArtFail(error: String) {
        homeView?.hideLoadingView()
        homeView?.showError(error: error)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        artworkResponse.results.count
    }
    
    func getArtworkViewModel(row: Int) -> ArtworkViewModel? {
        guard let title = artworkResponse.results[row].title, let artistDisplay = artworkResponse.results[row].artistDisplay, let dateDisplay = artworkResponse.results[row].dateDisplay else { return nil }
        return ArtworkViewModel(title: title, artistDisplay: artistDisplay)
    }
    
    func didScrollToBottom(row: Int) -> Bool {
        row == (artworkResponse.results.count) - 1
    }
    
    func didSelectRow(row: Int) {
        print("Selected")
    }
    
}
