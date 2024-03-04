//
//  UIViewController+Extensions.swift
//  MuseumArtworks
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit

extension UIViewController {
    func showLoadingView() {
        Loader.sharedLoader.show()
    }
    
    func hideLoadingView() {
        Loader.sharedLoader.hide()
    }
}
