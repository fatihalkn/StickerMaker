//
//  PayWallView.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import Foundation
import UIKit

protocol PayWallViewProtocol {
    func closeButtonClicked()
}

class PayWallView: UIView {
    
    //MARK: - Properties
    var payWallViewModel = PayWallViewModel()
    var delegate: PayWallViewProtocol?
    
    //MARK: - UI Elements
    lazy var closePageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .mainCreateView
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var restoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Restore", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var payWallImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = ._4
        return image
    }()
    
    lazy var stckrLabel: UILabel = {
        let label = UILabel()
        label.text = "Stckr"
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var proLabel: UILabel = {
        let label = UILabel()
        label.text = "PRO"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var premiumStickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Premium Sticker Maker"
        label.textColor = .lightGray
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pricingLabel: UILabel = {
        let label = UILabel()
        let fullText = "All features avaiable only with ₺79.99 / week. Cancel anytime"
        let boldText = "₺79.99 / week"
        let attributedString = NSMutableAttributedString(string: fullText)
        let boldFontAttribute: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .heavy)
        ]
        if let boldRange = fullText.range(of: boldText) {
            let nsRange = NSRange(boldRange, in: fullText)
            attributedString.addAttributes(boldFontAttribute, range: nsRange)
        }
        label.attributedText = attributedString
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var payWallCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var contiuneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Contiune with Plan", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var monthlyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Subscribe Monthly", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.titleEdgeInsets = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var monthlyPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "₺249,99"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var termsButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(string: "Terms of Service",attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 15)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var privacyButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(string: "Privacy Policy",attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 15)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTargetButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        closePageButton.layer.cornerRadius = closePageButton.frame.height / 2
        closePageButton.layer.masksToBounds = true
        
        restoreButton.layer.cornerRadius = 12
        restoreButton.layer.masksToBounds = true
        
        contiuneButton.layer.cornerRadius = 10
        contiuneButton.layer.masksToBounds = true
        
        monthlyButton.layer.cornerRadius = 10
        monthlyButton.layer.masksToBounds = true
    }
    
    func addTargetButtons() {
        closePageButton.addTarget(self, action: #selector(closePageButtonClicked), for: .touchUpInside)
    }
    
    @objc func closePageButtonClicked() {
        self.delegate?.closeButtonClicked()
    }
}

//MARK: - SetupUI
extension PayWallView {
    
    func setupUI() {
        backgroundColor = .white
        addSubview(closePageButton)
        addSubview(restoreButton)
        addSubview(payWallImage)
        addSubview(stckrLabel)
        addSubview(proLabel)
        addSubview(premiumStickerLabel)
        addSubview(payWallCollectionView)
        addSubview(pricingLabel)
        addSubview(contiuneButton)
        addSubview(monthlyButton)
        addSubview(monthlyPriceLabel)
        addSubview(termsButton)
        addSubview(privacyButton)
        setupRegister()
        setupDelegate()
        
        NSLayoutConstraint.activate([
            closePageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            closePageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            closePageButton.heightAnchor.constraint(equalToConstant: 30),
            closePageButton.widthAnchor.constraint(equalToConstant: 30),
            
            restoreButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            restoreButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,constant: -15),
            restoreButton.widthAnchor.constraint(equalToConstant: 70),
            restoreButton.heightAnchor.constraint(equalToConstant: 35),
            
            payWallImage.topAnchor.constraint(equalTo: restoreButton.bottomAnchor, constant: 10),
            payWallImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
            payWallImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            payWallImage.heightAnchor.constraint(lessThanOrEqualTo:safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            stckrLabel.topAnchor.constraint(equalTo: payWallImage.bottomAnchor),
            stckrLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            stckrLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            proLabel.topAnchor.constraint(equalTo: payWallImage.bottomAnchor),
            proLabel.leadingAnchor.constraint(equalTo: stckrLabel.trailingAnchor,constant: 10),
            proLabel.trailingAnchor.constraint(lessThanOrEqualTo:safeAreaLayoutGuide.trailingAnchor, constant: -50),
            proLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            premiumStickerLabel.topAnchor.constraint(equalTo: proLabel.bottomAnchor),
            premiumStickerLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            premiumStickerLabel.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor,constant: -50),
            premiumStickerLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            
            payWallCollectionView.topAnchor.constraint(equalTo: premiumStickerLabel.bottomAnchor),
            payWallCollectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            payWallCollectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            payWallCollectionView.heightAnchor.constraint(equalToConstant:100),
            
            pricingLabel.topAnchor.constraint(equalTo: payWallCollectionView.bottomAnchor),
            pricingLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            pricingLabel.trailingAnchor.constraint(lessThanOrEqualTo:safeAreaLayoutGuide.trailingAnchor),
            pricingLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            
            contiuneButton.topAnchor.constraint(equalTo: pricingLabel.bottomAnchor, constant: 10),
            contiuneButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            contiuneButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            contiuneButton.heightAnchor.constraint(equalToConstant: 60),
            
            monthlyButton.topAnchor.constraint(equalTo: contiuneButton.bottomAnchor, constant: 10),
            monthlyButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            monthlyButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            monthlyButton.heightAnchor.constraint(equalToConstant: 60),
            
            monthlyPriceLabel.centerXAnchor.constraint(equalTo: monthlyButton.centerXAnchor),
            monthlyPriceLabel.centerYAnchor.constraint(equalTo: monthlyButton.centerYAnchor,constant: 10),
            monthlyPriceLabel.heightAnchor.constraint(equalToConstant: 15),
            monthlyPriceLabel.widthAnchor.constraint(greaterThanOrEqualToConstant:30),
            
            termsButton.topAnchor.constraint(equalTo: monthlyButton.bottomAnchor, constant: 20),
            termsButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            termsButton.trailingAnchor.constraint(lessThanOrEqualTo:privacyButton.leadingAnchor, constant: -30),
            termsButton.heightAnchor.constraint(equalToConstant: 30),
            
            privacyButton.topAnchor.constraint(equalTo: monthlyButton.bottomAnchor,constant: 20),
            privacyButton.trailingAnchor.constraint(equalTo: monthlyButton.trailingAnchor,constant: -15),
            privacyButton.heightAnchor.constraint(equalToConstant: 30)
            
            
           
            
            
            
        ])
    }
    
    func setupRegister() {
        payWallCollectionView.register(PremiumFeaturesCollectionViewCell.self, forCellWithReuseIdentifier: PremiumFeaturesCollectionViewCell.identifier)
    }
    
    func setupDelegate() {
        payWallCollectionView.delegate = self
        payWallCollectionView.dataSource = self
    }
    
}

//MARK: - UIcollectionView Configure
extension PayWallView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(payWallViewModel.featuresModel.count)
        return payWallViewModel.featuresModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PremiumFeaturesCollectionViewCell.identifier, for: indexPath) as!
        PremiumFeaturesCollectionViewCell
        let model = payWallViewModel.featuresModel[indexPath.item].features
        cell.featuresLabel.text = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 20
        let cellHeight: CGFloat = 30
        return .init(width: cellWidth, height: cellHeight)
    }
    

    
}
