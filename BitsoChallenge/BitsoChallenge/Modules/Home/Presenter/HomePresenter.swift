//
//  HomePresenter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
    func fetchArtworks(page: Int)
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse)
    func onFetchPiecesOfArtFail(error: String)
    func numberOfItemsInSection(section: Int) -> Int
    func getArtworkViewModel(row: Int) -> ArtworkViewModel?
    func didScrollToBottom(row: Int) -> Bool
    func didSelectRow(row: Int)
}

class HomePresenter: HomePresenterProtocols {
    
    var artworkResponse: ArtworkListResponse = ArtworkListResponse(results: [])
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    func fetchArtworks(page: Int) {
        homeView?.showLoadingView()
        homeInteractor?.retrieveArtworks(page: page)
    }
    
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse) {
        homeView?.hideLoadingView()
        homeView?.handleErrorViewVisibility(isHidden: true)
        artworkResponse.results.append(contentsOf: response.results)
        homeView?.reloadCollectionView()
        homeView?.updateCurrentPage()
    }
    
    func onFetchPiecesOfArtFail(error: String) {
        homeView?.hideLoadingView()
        homeView?.handleErrorViewVisibility(isHidden: false)
        homeView?.setErrorMessage(error: error)
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        artworkResponse.results.count
    }
    
    func getArtworkViewModel(row: Int) -> ArtworkViewModel? {
        guard let title = artworkResponse.results[row].title, let artists = artworkResponse.results[row].artistTitles else { return nil }
        return ArtworkViewModel(title: title, artists: artists.reduce("", {$0 + " - " + $1}))
    }
    
    func didScrollToBottom(row: Int) -> Bool {
        row == (artworkResponse.results.count) - 1
    }
    
    func didSelectRow(row: Int) {
        guard let id = artworkResponse.results[row].id else {
            homeView?.showErrorAlertView(error: "There's been a problem. Try again later")
            return
        }
        homeRouter?.goToDetail(networkProvider: homeInteractor?.provider ?? NetworkProvider(), id: id)
    }
    
}
