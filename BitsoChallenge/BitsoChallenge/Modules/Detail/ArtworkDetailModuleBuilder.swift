//
//  ArtworkDetailModuleBuilder.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import UIKit
import SwiftUI

class ArtworkDetailModuleBuilder {
    static func build(with provider: NetworkProviderProtocol, id: Int) -> UIHostingController<ArtworkDetailView> {
        let viewModel = ArtworkDetailViewModel(provider: provider, id: id)
        let view = ArtworkDetailView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
