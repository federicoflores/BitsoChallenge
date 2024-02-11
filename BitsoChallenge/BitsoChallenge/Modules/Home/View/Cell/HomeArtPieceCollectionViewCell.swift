//
//  HomeArtPieceCollectionViewCell.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit

class HomeArtPieceCollectionViewCell: UICollectionViewCell {
    
    fileprivate enum Constant {
        static let backgroundColorRedProportion: Int = 33
        static let backgroundColorGreenProportion: Int = 40
        static let backgroundColorBlueProportion: Int = 51
        static let labelNumberOfLines: Int = 0
        static let labelTrailing: CGFloat = 8
        static let titleLabelFont: CGFloat = 22
        static let titleLabelPadding: CGFloat = 8
        static let subtitleLabelTop: CGFloat = 2
        static let subtitleLabelBottom: CGFloat = 8
        static let chevronImageViewSize: CGFloat = 20
        static let chevronImageViewTrailing: CGFloat = 8
        static let chevronRightIconName: String = "chevron.right"
    }
            
    fileprivate let titleLabel: UILabel = UILabel()
    fileprivate let subtitleLabel: UILabel = UILabel()
    fileprivate let chevronImageView: UIImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    private func setup() {
        contentView.backgroundColor = UIColor(
            red: Constant.backgroundColorRedProportion,
            green: Constant.backgroundColorGreenProportion,
            blue: Constant.backgroundColorBlueProportion)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(chevronImageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Titlelabel
        titleLabel.numberOfLines = Constant.labelNumberOfLines
        titleLabel.font = .boldSystemFont(ofSize: Constant.titleLabelFont)
        titleLabel.textColor = UIColor.white
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: Constant.titleLabelPadding).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.titleLabelPadding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Constant.labelTrailing).isActive = true
        
        
        //SubtitleLabel
        subtitleLabel.numberOfLines = Constant.labelNumberOfLines
        subtitleLabel.textColor = UIColor.lightGray
        subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -Constant.labelTrailing).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.subtitleLabelTop).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.subtitleLabelBottom).isActive = true
                                
        //ChevronImageView
        
        chevronImageView.image = UIImage(systemName: Constant.chevronRightIconName)
        chevronImageView.image = chevronImageView.image?.withRenderingMode(.alwaysTemplate)
        chevronImageView.tintColor = UIColor.lightGray
        
        chevronImageView.widthAnchor.constraint(equalToConstant: Constant.chevronImageViewSize).isActive = true
        chevronImageView.heightAnchor.constraint(equalToConstant: Constant.chevronImageViewSize).isActive = true
        chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.chevronImageViewTrailing).isActive = true
    }
    
    func bind(with artworkViewModel: ArtworkViewModel?) {
        guard let viewModel = artworkViewModel else { return }
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.artists
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }
    
}
