//
//  HomeViewSnapshotTests.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 11/02/2024.
//

import XCTest
@testable import MuseumArtworks
import SnapshotTesting

final class HomeViewSnapshotTests: XCTestCase {
    
    var sut: UIViewController?
    
    override func setUpWithError() throws {
        sut = HomeModuleBuilderStub.build()
    }
    
    func testHomeViewController() {
        guard let sut = sut else { return }
        assertSnapshot(of: sut, as: .image)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

}
