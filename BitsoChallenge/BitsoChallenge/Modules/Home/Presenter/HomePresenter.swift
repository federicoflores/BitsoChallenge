//
//  HomePresenter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import Foundation

protocol HomePresenterProtocols: AnyObject {
}

class HomePresenter: HomePresenterProtocols {
    
    weak var homeView: HomeViewProtocols?
    var homeInteractor: HomeInteractorProtocols?
    var homeRouter: HomeRouterProtocols?
    
    
}
