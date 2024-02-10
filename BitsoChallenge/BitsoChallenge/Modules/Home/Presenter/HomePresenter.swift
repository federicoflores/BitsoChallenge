//
//  HomePresenter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
    var isFetchingData: Bool { get set }
    func fetchArtworks(page: Int)
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse)
    func onFetchPiecesOfArtFail(error: String)
    func numberOfItemsInSection(section: Int) -> Int
    func getArtworkViewModel(row: Int) -> ArtworkViewModel?
    func didScrollToBottom(row: Int) -> Bool
    func didSelectRow(row: Int)
    func userDidScroll(page: Int)
}

class HomePresenter: HomePresenterProtocols {
    
    fileprivate enum Constant {
        static let delay: CGFloat = 0.33
    }
    
    enum ResponseState {
        case onEmpty
        case onSucceed
        case onError
    }
    
    var artworkResponse: ArtworkListResponse = ArtworkListResponse(results: [])
    private var auxResponse: ArtworkListResponse = ArtworkListResponse(results: [])
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    var isFetchingData: Bool = false
    var responseState: ResponseState = .onEmpty
    
    func fetchArtworks(page: Int) {
        isFetchingData = true
        homeView?.showLoadingView()
        homeInteractor?.retrieveArtworks(page: page)
    }
    
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse) {
        switch responseState {
        case .onEmpty:
            homeView?.hideLoadingView()
            homeView?.handleErrorViewVisibility(isHidden: true)
            artworkResponse.results.append(contentsOf: response.results)
        case .onSucceed:
            auxResponse = response
        case .onError:
            homeView?.hideLoadingView()
            homeView?.handleErrorViewVisibility(isHidden: true)
            artworkResponse.results = response.results
        }
        setUserDefaultsResponseIfNeeded(isFirstCall: response.pagination?.currentPage == 1)
        responseState = .onSucceed
        isFetchingData = false
        homeView?.reloadCollectionView()
        homeView?.updateCurrentPage()
    }
    
    func userDidScroll(page: Int) {
        isFetchingData = true
        if responseState == .onSucceed {
            showLoadingViewWhileScrolling()
            artworkResponse.results.append(contentsOf: auxResponse.results)
            auxResponse.results = []
            homeView?.reloadCollectionView()
        }
        homeInteractor?.retrieveArtworks(page: page)
    }
    
    private func showLoadingViewWhileScrolling() {
        homeView?.showLoadingView()
        DispatchQueue.main.asyncAfter(deadline: .now() + Constant.delay, execute: { [weak self] in
            self?.homeView?.hideLoadingView()
        })
    }
    
    func onFetchPiecesOfArtFail(error: String) {
        isFetchingData = false
        getDataFromUserDefaults()
        
        if responseState == .onEmpty {
            homeView?.handleErrorViewVisibility(isHidden: false)
            homeView?.setErrorMessage(error: error)
        }
        homeView?.hideLoadingView()
        responseState = .onError
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        artworkResponse.results.count
    }
    
    func getArtworkViewModel(row: Int) -> ArtworkViewModel? {
        guard let title = artworkResponse.results[row].title, let artists = artworkResponse.results[row].artistTitles else { return nil }
        return ArtworkViewModel(title: title, artists: artists.reduce("", {$0 + " - " + $1}))
    }
    
    func didScrollToBottom(row: Int) -> Bool {
        row == (artworkResponse.results.count) - 2
    }
    
    func didSelectRow(row: Int) {
        guard let id = artworkResponse.results[row].id else {
            homeView?.showErrorAlertView(error: "There's been a problem. Try again later")
            return
        }
        homeRouter?.goToDetail(networkProvider: homeInteractor?.provider ?? NetworkProvider(), id: id)
    }
}

extension HomePresenter {
    fileprivate func setUserDefaultsResponseIfNeeded(isFirstCall: Bool) {
        if isFirstCall {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(artworkResponse)
                UserDefaults.standard.set(data, forKey: "artworkResponse")
            }
            catch {
                print(error)
            }
        }
    }
    
    
    private func getDataFromUserDefaults() {
        if responseState == .onEmpty {
            if let savedModel = UserDefaults.standard.value(forKey: "artworkResponse") as? Data {
                if let decodedData = try? JSONDecoder().decode(ArtworkListResponse.self, from: savedModel) {
                    artworkResponse = decodedData
                    homeView?.hideLoadingView()
                    homeView?.reloadCollectionView()
                    responseState = .onError
                    return
                }
            }
        }
    }
}
