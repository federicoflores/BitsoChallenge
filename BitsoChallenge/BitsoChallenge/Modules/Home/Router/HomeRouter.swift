//
//  HomeRouter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit
import SwiftUI

protocol HomeRouterProtocols: AnyObject {
    func goToDetail(networkProvider: NetworkProviderProtocol, id: Int)
}

class HomeRouter: HomeRouterProtocols {
    
    weak var viewController: UIViewController?
    
    func goToDetail(networkProvider: NetworkProviderProtocol, id: Int) {
        let vc = ArtworkDetailModuleBuilder.build(with: networkProvider, id: id)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}


