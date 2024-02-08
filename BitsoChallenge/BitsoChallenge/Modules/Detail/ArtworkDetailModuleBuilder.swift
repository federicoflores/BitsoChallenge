//
//  ArtworkDetailModuleBuilder.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import UIKit
import SwiftUI

class ArtworkDetailModuleBuilder {
    static func build(with provider: NetworkProvider, id: Int) -> UIHostingController<ArtworkDetailView> {
        let viewModel = ArtworkDetailViewModel(provider: provider, id: id)
        let view = ArtworkDetailView(viewModel: viewModel)
        return UIHostingController(rootView: view)
    }
}
