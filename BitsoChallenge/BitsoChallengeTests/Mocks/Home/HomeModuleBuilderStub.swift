//
//  HomeModuleBuilderStub.swift
//  BitsoChallengeTests
//
//  Created by Fede Flores on 11/02/2024.
//

import UIKit
@testable import BitsoChallenge

class HomeModuleBuilderStub {
    static func build() -> UIViewController {
        let view: HomeViewController = HomeViewController()
        let presenter: HomePresenter = HomePresenter()
        let interactor: HomeInteractor = HomeInteractor(provider: NetworkProviderStub())
        let router: HomeRouter = HomeRouter()
        
        view.homePresenter = presenter
        
        presenter.homeView = view
        presenter.homeRouter = router
        presenter.homeInteractor = interactor
        
        interactor.homePresenter = presenter
        
        router.viewController = view
        
        return view
    }
}

