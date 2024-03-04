//
//  HomeInteractorMocks.swift
//  MuseumArtworksTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import MuseumArtworks

class HomeInteractorMocks: HomeInteractorProtocols {
    var numberOfTimesRetrieveArtworksCalled: Int = 0
    
    var provider: MuseumArtworks.NetworkProviderProtocol = NetworkProviderStub()
    
    func retrieveArtworks(page: Int) {
        numberOfTimesRetrieveArtworksCalled += 1
    }
    
}


