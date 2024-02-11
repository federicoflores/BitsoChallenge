//
//  HomeInteractorTests.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import XCTest
@testable import BitsoChallenge

final class HomeInteractorTests: XCTestCase {
    
    var presenter: HomePresenterMocks?
    var sut: HomeInteractor?
    
    override func setUpWithError() throws {
        sut = HomeInteractor(provider: NetworkProviderStub())
        presenter = HomePresenterMocks()
        
        sut?.homePresenter = presenter
    }
    
    //Flag for succeed has been set as page == 1 on Network provider mock
    func testOnRetrieveArtworksSuccess() {
        sut?.retrieveArtworks(page: 1)
        
        XCTAssertEqual(presenter?.numberOfTimesOnFetchPiecesOfArtSuccessCalled, 1)
        XCTAssertNotEqual(presenter?.numberOfTimesOnFetchPiecesOfArtSuccessCalled, 0)
    }
    
    //Flag for succeed has been set as page == 0 on Network provider mock
    func testOnRetrieveArtworksFails() {
        sut?.retrieveArtworks(page: 0)
        
        XCTAssertEqual(presenter?.numberOfTimesOnFetchPiecesOfArtFailCalled, 1)
        XCTAssertNotEqual(presenter?.numberOfTimesOnFetchPiecesOfArtFailCalled, 0)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        presenter = nil
    }
    
}
