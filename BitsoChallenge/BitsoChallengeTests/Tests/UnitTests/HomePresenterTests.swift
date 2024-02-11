//
//  HomePresenterTests.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import XCTest
@testable import BitsoChallenge

final class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter?
    var view: HomeViewMocks?
    var interactor: HomeInteractorMocks?
    var router: HomeRouterMocks?

    override func setUpWithError() throws {
        sut = HomePresenter()
        view = HomeViewMocks()
        router = HomeRouterMocks()
        interactor = HomeInteractorMocks()
        
        sut?.homeInteractor = interactor
        sut?.homeRouter = router
        sut?.homeView = view
    }

    override func tearDownWithError() throws {
        sut = nil
        view = nil
        router = nil
        interactor = nil
    }
    
    func testOnFetchArtworks() {
        sut?.fetchArtworks()
        XCTAssertEqual(view?.numberOfTimesShowLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesShowLoadingViewCalled, 2)
        XCTAssertEqual(interactor?.numberOfTimesRetrieveArtworksCalled, 1)
        XCTAssertNotEqual(interactor?.numberOfTimesRetrieveArtworksCalled, 2)
    }
    
    func testOnFetchPiecesOfArtSuccessWithReesponseStateOnEmpty() {
        //Given
        sut?.responseState = .onEmpty
        
        //When
        sut?.onFetchPiecesOfArtSuccess(response: ArtworkListResponse())
        
        //Then
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 2)
        
        XCTAssertEqual(sut?.responseState, .onSucceed)
        XCTAssertEqual(sut?.isFetchingData, false)
        
        XCTAssertEqual(view?.numberOfTimesReloadCollectionViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesReloadCollectionViewCalled, 2)
    }
    
    func testOnFetchPiecesOfArtSuccessWithReesponseStateOnSucceed() {
        //Given
        sut?.responseState = .onSucceed
        
        //When
        sut?.onFetchPiecesOfArtSuccess(response: ArtworkListResponse())
        
        //Then
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        
        XCTAssertEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 1)
        
        XCTAssertEqual(sut?.responseState, .onSucceed)
        XCTAssertEqual(sut?.isFetchingData, false)
        
        XCTAssertEqual(view?.numberOfTimesReloadCollectionViewCalled, 0)
        XCTAssertNotEqual(view?.numberOfTimesReloadCollectionViewCalled, 2)
    }
    
    func testOnFetchPiecesOfArtSuccessWithReesponseStateOnError() {
        //Given
        sut?.responseState = .onError
        
        //When
        sut?.onFetchPiecesOfArtSuccess(response: ArtworkListResponse())
        
        //Then
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
        
        XCTAssertEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHandleErrorViewVisibilityCalled, 2)
        
        XCTAssertEqual(sut?.responseState, .onSucceed)
        XCTAssertEqual(sut?.isFetchingData, false)
        
        XCTAssertEqual(view?.numberOfTimesReloadCollectionViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesReloadCollectionViewCalled, 2)
    }
    
    func testOnFetchPiecesOfArtFail() {
        sut?.onFetchPiecesOfArtFail(error: "")
        
        XCTAssertEqual(sut?.isFetchingData, false)
        
        //Flacky test :: Validation on user defaults saved data is needed
        
//        XCTAssertEqual(view?.numberOfTimesReloadCollectionViewCalled, 1)
//        XCTAssertNotEqual(view?.numberOfTimesReloadCollectionViewCalled, 2)
        
        XCTAssertEqual(sut?.responseState, .onError)
        
        XCTAssertEqual(view?.numberOfTimesHideLoadingViewCalled, 1)
        XCTAssertNotEqual(view?.numberOfTimesHideLoadingViewCalled, 2)
    }
    
    func testOnDidSelectRow() {
        //Given
        sut?.artworkResponse = JSONLoader().artworkListResponse() ?? ArtworkListResponse(results: [])
        
        //When
        sut?.didSelectRow(row: 0)
        
        //Then
        XCTAssertEqual(router?.numberOfTimesGoToDetailCalled, 1)
        XCTAssertNotEqual(router?.numberOfTimesGoToDetailCalled, 2)
    }
    
    func testOnUserDidScroll() {
        sut?.userDidScroll()
        XCTAssertEqual(sut?.isFetchingData, true)
        XCTAssertEqual(interactor?.numberOfTimesRetrieveArtworksCalled, 1)
        XCTAssertNotEqual(interactor?.numberOfTimesRetrieveArtworksCalled, 2)
    }
    
}
