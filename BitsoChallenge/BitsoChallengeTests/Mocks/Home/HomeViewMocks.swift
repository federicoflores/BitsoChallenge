//
//  HomeViewMocks.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 10/02/2024.
//

import Foundation
@testable import BitsoChallenge

class HomeViewMocks: HomeViewProtocols {
    
    var numberOfTimesReloadCollectionViewCalled: Int = 0
    var numberOfTimesShowErrorAlertViewCalled: Int = 0
    var numberOfTimesShowLoadingViewCalled: Int = 0
    var numberOfTimesHideLoadingViewCalled: Int = 0
    var numberOfTimesHandleErrorViewVisibilityCalled: Int = 0
    var numberOfTimesSetErrorMessageCalled: Int = 0
    
    func reloadCollectionView() {
        numberOfTimesReloadCollectionViewCalled += 1
    }
    
    func showErrorAlertView(error: String) {
        numberOfTimesShowErrorAlertViewCalled += 1
    }
    
    func showLoadingView() {
        numberOfTimesShowLoadingViewCalled += 1
    }
    
    func hideLoadingView() {
        numberOfTimesHideLoadingViewCalled += 1
    }
    
    func handleErrorViewVisibility(isHidden: Bool) {
        numberOfTimesHandleErrorViewVisibilityCalled += 1
    }
    
    func setErrorMessage(error: String) {
        numberOfTimesSetErrorMessageCalled += 1
    }
    
}
