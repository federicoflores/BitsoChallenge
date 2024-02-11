//
//  HomeRouterMocks.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import BitsoChallenge

class HomeRouterMocks: HomeRouterProtocols {
    var numberOfTimesGoToDetailCalled = 0
    
    func goToDetail(networkProvider: BitsoChallenge.NetworkProviderProtocol, id: Int) {
        numberOfTimesGoToDetailCalled += 1
    }
    
}
