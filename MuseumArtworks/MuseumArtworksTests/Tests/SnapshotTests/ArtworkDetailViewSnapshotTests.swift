//
//  ArtworkDetailViewSnapshotTests.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 11/02/2024.
//

import XCTest
@testable import MuseumArtworks
import SnapshotTesting
import SwiftUI

final class ArtworkDetailViewSnapshotTests: XCTestCase {
    
    var sut: UIViewController?

    override func setUpWithError() throws {
        sut = ArtworkDetailModuleBuilder.build(with: NetworkProviderStub(), id: 1)
    }
    
    func testArtworkDetailSuccess() {
        guard let sut = sut as? UIHostingController<ArtworkDetailView> else { return }
        sut.rootView.viewModel.artworkDetailState = .success
        assertSnapshot(of: sut, as: .image)
    }
    
    func testArtworkDetailLoading() {
        guard let sut = sut as? UIHostingController<ArtworkDetailView> else { return }
        sut.rootView.viewModel.artworkDetailState = .loading
        assertSnapshot(of: sut, as: .image)
    }
    
    func testArtworkDetailError() {
        guard let sut = sut as? UIHostingController<ArtworkDetailView> else { return }
        sut.rootView.viewModel.artworkDetailState = .error(error: "The internet connection appears to be offline")
        assertSnapshot(of: sut, as: .image)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

}
