//
//  ArtworkDetailModuleBuilderStub.swift
//  MuseumArtworksTests
//
//  Created by Fede Flores on 11/02/2024.
//

import UIKit
import SwiftUI
@testable import MuseumArtworks

class ArtworkDetailModuleBuilderStub {
    static func build(with provider: NetworkProviderProtocol, id: Int) -> UIHostingController<ArtworkDetailView> {
        let viewModel = ArtworkDetailViewModel(provider: provider, id: id)
        let view = ArtworkDetailView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}

