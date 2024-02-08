//
//  UIKitErrorView.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 08/02/2024.
//

import UIKit

class UIKitErrorView: UIView {
    
    let action: ()?
    let titleText: String?
    let subtitleText: String?
    let buttonText: String?
    
    let imageView = UIImageView(image: UIImage(systemName: "heart"))
    let titleLabel: UILabel = UILabel()
    let subtitleLabel: UILabel = UILabel()
    let button: UIButton = UIButton()
    
    init(action: ()? = nil, titleText: String?, subtitleText: String?, buttonText: String?) {
        self.action = action
        self.titleText = titleText
        self.subtitleText = subtitleText
        self.buttonText = buttonText
        super.init()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        backgroundColor = UIColor.black
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(button)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.font = .italicSystemFont(ofSize: 26)
        titleLabel.text = titleText
        titleLabel.textColor = UIColor.white
        
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        subtitleLabel.font = .systemFont(ofSize: 20)
        subtitleLabel.text = subtitleText
        subtitleLabel.textColor = UIColor.lightGray
        
        button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: leadingAnchor, constant: -40).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        button.setTitle(buttonText, for: .normal)
        
        
        
        
    }
    
    
    
}
