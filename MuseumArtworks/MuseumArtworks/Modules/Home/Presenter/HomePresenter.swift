//
//  HomePresenter.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
    var artworkResponse: ArtworkListResponse { get}
    var isFetchingData: Bool { get }
    var responseState: HomePresenter.ResponseState { get}
    func fetchArtworks()
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse)
    func onFetchPiecesOfArtFail(error: String)
    func numberOfItemsInSection() -> Int
    func getArtworkViewModel(row: Int) -> ArtworkViewModel?
    func didScrollToBottom(row: Int) -> Bool
    func didSelectRow(row: Int)
    func userDidScroll()
}

class HomePresenter: HomePresenterProtocols {
    
    fileprivate enum Constant {
        static let delay: CGFloat = 0.33
        static let userDefaultsArtworksResponseKey: String = "artworkResponse"
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
    private var currentPage = 1
    
    func fetchArtworks() {
        isFetchingData = true
        homeView?.showLoadingView()
        homeInteractor?.retrieveArtworks(page: currentPage)
    }
    
    func onFetchPiecesOfArtSuccess(response: ArtworkListResponse) {
        switch responseState {
        case .onEmpty:
            homeView?.hideLoadingView()
            homeView?.handleErrorViewVisibility(isHidden: true)
            artworkResponse.results.append(contentsOf: response.results)
            homeView?.reloadCollectionView()
        case .onSucceed:
            auxResponse = response
        case .onError:
            homeView?.hideLoadingView()
            homeView?.handleErrorViewVisibility(isHidden: true)
            artworkResponse.results = response.results
            homeView?.reloadCollectionView()
        }
        responseState = .onSucceed
        isFetchingData = false
        currentPage += 1
        
        handleFirstCallBehaviours(isFirstCall: response.pagination?.currentPage == 1)
    }
    
    private func handleFirstCallBehaviours(isFirstCall: Bool) {
        if isFirstCall {
            isFetchingData = true
            setUserDefaultsResponse()
            homeInteractor?.retrieveArtworks(page: currentPage)
        }
    }
    
    func userDidScroll() {
        isFetchingData = true
        if responseState == .onSucceed, !auxResponse.results.isEmpty {
            var rowIndexs: [Int] = []
            
            for index in 0..<auxResponse.results.count {
                rowIndexs.append(artworkResponse.results.count + index)
            }
            artworkResponse.results.append(contentsOf: auxResponse.results)
            homeView?.updateItems(at: rowIndexs)
            auxResponse.results = []
        }
        homeInteractor?.retrieveArtworks(page: currentPage)
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
    
    func numberOfItemsInSection() -> Int {
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

extension HomePresenter {
    fileprivate func setUserDefaultsResponse() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(artworkResponse)
            UserDefaults.standard.set(data, forKey: Constant.userDefaultsArtworksResponseKey)
        }
        catch {
            print(error)
        }
    }
    
    private func getDataFromUserDefaults() {
        if responseState == .onEmpty {
            if let savedModel = UserDefaults.standard.value(forKey: Constant.userDefaultsArtworksResponseKey) as? Data {
                if let decodedData = try? JSONDecoder().decode(ArtworkListResponse.self, from: savedModel) {
                    artworkResponse = decodedData
                    homeView?.reloadCollectionView()
                    responseState = .onError
                    return
                }
            }
        }
    }
}
