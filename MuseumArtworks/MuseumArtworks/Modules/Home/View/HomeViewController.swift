//
//  HomeViewController.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit
import SwiftUI

protocol HomeViewProtocols: AnyObject {
    func reloadCollectionView()
    func showErrorAlertView(error: String)
    func showLoadingView()
    func hideLoadingView()
    func handleErrorViewVisibility(isHidden: Bool)
    func setErrorMessage(error: String)
    func updateItems(at rows:[Int])
}

class HomeViewController: UIViewController {
    
    fileprivate enum Constant {
        static let titleLabelFont: CGFloat = 30
        static let collectionViewTopAnchor: CGFloat = 32
        static let cellCornerRadius: CGFloat = 12
        static let collectionViewLayoutSpacing: CGFloat = 4
        static let collectionViewPaddingMultiplier: CGFloat = 0.1
    }
    
    fileprivate enum Wording {
        static let alertViewTitle: String = "Error"
        static let titlelabelText: String = "Art institute of Chicago"
    }
    
    var homePresenter: HomePresenterProtocols?
    
    fileprivate let collectionView: UICollectionView = {
        let layout = ArtworkFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = Constant.collectionViewLayoutSpacing
        layout.minimumLineSpacing = Constant.collectionViewLayoutSpacing
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    fileprivate let titleLabel: UILabel = UILabel()
    
    fileprivate var errorView: UIHostingController<ErrorView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        homePresenter?.fetchArtworks()
    }
    
    fileprivate func setupViews() {
        errorView = UIHostingController(rootView: ErrorView(action: loadData))
        guard let errorView = errorView  else { return }
        addChild(errorView)
        errorView.view.frame = view.frame
        
        setNavigationControllerBackgroundLayer()
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(errorView.view)
        errorView.didMove(toParent: self)
        errorView.view.isHidden = true
        
        //Title Label
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * Constant.collectionViewPaddingMultiplier / 2).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -view.bounds.width * Constant.collectionViewPaddingMultiplier / 2).isActive = true
        
        titleLabel.text = Wording.titlelabelText
        titleLabel.font = .boldSystemFont(ofSize: Constant.titleLabelFont)
        titleLabel.textColor = UIColor.white
        
        //CollectionView
        
        collectionView.backgroundColor = UIColor.black
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.collectionViewTopAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setNavigationControllerBackgroundLayer() {
        guard let navigationController = navigationController else { return }
        let gradientLayer = CAGradientLayer()
        var updatedFrame = navigationController.navigationBar.bounds
        updatedFrame.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        gradientLayer.frame = updatedFrame
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.lightGray.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let uiGraphicsCurrentContext = UIGraphicsGetCurrentContext() else { return }
        gradientLayer.render(in: uiGraphicsCurrentContext)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        navigationController.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        let appearance = navigationController.navigationBar.standardAppearance.copy()
        appearance.backgroundImage = image
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HomeArtPieceCollectionViewCell.self))
    }
    
    private func loadData() {
        homePresenter?.fetchArtworks()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homePresenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeArtPieceCollectionViewCell.self), for: indexPath) as? HomeArtPieceCollectionViewCell else { return UICollectionViewCell() }
        cell.contentView.layer.cornerRadius = Constant.cellCornerRadius
        cell.bind(with: homePresenter?.getArtworkViewModel(row: indexPath.row))
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homePresenter?.didSelectRow(row: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let didScrollToBottom = homePresenter?.didScrollToBottom(row: indexPath.row), didScrollToBottom, let isFetchingData = homePresenter?.isFetchingData, !isFetchingData {
            homePresenter?.userDidScroll()
        }
    }
}

extension HomeViewController: HomeViewProtocols {
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setErrorMessage(error: String) {
        errorView?.rootView.subtitle = error
    }
    
    func showErrorAlertView(error: String) {
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Wording.alertViewTitle, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func handleErrorViewVisibility(isHidden: Bool) {
        if let errorView = errorView {
            errorView.view.isHidden = isHidden
        }
    }
    
    func updateItems(at rows:[Int]) {
        UIView.setAnimationsEnabled(false)
        let indexPaths = rows.map { IndexPath(row: $0, section: 0)}
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: indexPaths)
        }
        UIView.setAnimationsEnabled(true)
    }
}

final class ArtworkFlowLayout : UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
            let layoutAttributesObjects = super.layoutAttributesForElements(in: rect)?.map{ $0.copy() } as? [UICollectionViewLayoutAttributes]
            layoutAttributesObjects?.forEach({ layoutAttributes in
                if layoutAttributes.representedElementCategory == .cell {
                    if let newFrame = layoutAttributesForItem(at: layoutAttributes.indexPath)?.frame {
                        layoutAttributes.frame = newFrame
                    }
                }
            })
            return layoutAttributesObjects
        }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { fatalError() }
        guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes else {
            return nil
        }

        layoutAttributes.frame.origin.x = sectionInset.left
        layoutAttributes.frame.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
        return layoutAttributes
    }
    
}
