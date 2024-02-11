//
//  ArtworkDetailViewModelTests.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import XCTest
@testable import BitsoChallenge

final class ArtworkDetailViewModelTests: XCTestCase {
    var provider: NetworkProviderProtocol?
    var sut: ArtworkDetailViewModel?
    

    override func setUpWithError() throws {
        provider = NetworkProviderStub()
        sut = ArtworkDetailViewModel(provider: provider ?? NetworkProviderStub(), id: 1)
    }
    
    func testRetrieveArtoworkDetail() {
        sut?.retrieveArtoworkDetail(id: 1)
        XCTAssertNotNil(sut?.artwork)
    }

    override func tearDownWithError() throws {
        provider = nil
        sut = nil
    }
}
