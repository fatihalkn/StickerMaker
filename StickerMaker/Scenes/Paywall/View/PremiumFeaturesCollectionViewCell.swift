//
//  PremiumFeaturesCollectionViewCell.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import UIKit

class PremiumFeaturesCollectionViewCell: UICollectionViewCell {
    static let identifier = "PremiumFeaturesCollectionViewCell"
    
    let featuresLabel: UILabel = {
       let label = UILabel()
       label.textColor = .black
       label.font = .systemFont(ofSize: 18, weight: .bold)
       label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .left
       label.textAlignment = .center
       return label
   }()
    
    
    let checkmarkImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = .checkmark
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

//MARK: - SetupUI
extension PremiumFeaturesCollectionViewCell {
    
    func setupUI() {
        addSubview(featuresLabel)
        addSubview(checkmarkImage)
        
        NSLayoutConstraint.activate([
            checkmarkImage.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            checkmarkImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            checkmarkImage.heightAnchor.constraint(equalToConstant: 30),
            checkmarkImage.widthAnchor.constraint(equalToConstant: 30),
            
            featuresLabel.centerYAnchor.constraint(equalTo: checkmarkImage.centerYAnchor),
            featuresLabel.centerXAnchor.constraint(equalTo: checkmarkImage.centerXAnchor,constant: 140),
            featuresLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
