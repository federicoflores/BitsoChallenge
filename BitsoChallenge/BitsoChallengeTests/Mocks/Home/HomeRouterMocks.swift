//
//  HomeRouterMocks.swift
//  MuseumArtworksTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import MuseumArtworks

class HomeRouterMocks: HomeRouterProtocols {
    var numberOfTimesGoToDetailCalled = 0
    
    func goToDetail(networkProvider: MuseumArtworks.NetworkProviderProtocol, id: Int) {
        numberOfTimesGoToDetailCalled += 1
    }
    
}
