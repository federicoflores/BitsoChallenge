//
//  HomeRouter.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit

protocol HomeRouterProtocols: AnyObject {
    func goToDetail()
}

class HomeRouter: HomeRouterProtocols {
    
    weak var viewController: UIViewController?
    
    func goToDetail() {
        let vc = UIViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}


