//
//  HomeViewController.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit

protocol HomeViewProtocols: AnyObject {
    func reloadCollectionView()
    func showError(error: String)
    func showLoadingView()
    func hideLoadingView()
}

class HomeViewController: UIViewController {
    
    var homePresenter: HomePresenterProtocols?
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    fileprivate let titleLabel: UILabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
}

extension HomeViewController: HomeViewProtocols {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Error", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
}
