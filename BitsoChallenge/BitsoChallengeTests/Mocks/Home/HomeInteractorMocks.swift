//
//  HomeInteractorMocks.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import BitsoChallenge

class HomeInteractorMocks: HomeInteractorProtocols {
    var numberOfTimesRetrieveArtworksCalled: Int = 0
    
    var provider: BitsoChallenge.NetworkProviderProtocol = NetworkProviderMock()
    
    func retrieveArtworks(page: Int) {
        numberOfTimesRetrieveArtworksCalled += 1
    }
    
}


