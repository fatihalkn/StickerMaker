//
//  HomeView.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation
import UIKit

final class HomeView: UIView {
    
    //MARK: - UI Elements
   lazy var mainCreateView: UIView = {
        let view = UIView()
       view.backgroundColor = .mainCreateView
       view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var randomStickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .button
        button.setTitle("Create", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var promptText: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: textField.frame.height))
        textField.leftView = leftPaddingView
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: textField.frame.height))
        textField.rightView = rightPaddingView
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.placeholder = "Write Something"
        textField.backgroundColor = .textField
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.8
        textField.font = .systemFont(ofSize: 12, weight: .bold)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var supriseMeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "Suprise Me ✨"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupUI
private extension HomeView {
    
    func setupRadius() {
        mainCreateView.layer.cornerRadius = 12
        mainCreateView.layer.masksToBounds = true
        
        promptText.layer.cornerRadius = 12
        promptText.layer.masksToBounds = true
        
        createButton.layer.cornerRadius = 12
        createButton.layer.masksToBounds  = true
        
        randomStickerImageView.layer.cornerRadius = randomStickerImageView.frame.height / 2
        randomStickerImageView.layer.masksToBounds = true
    }
    func setupUI() {
        backgroundColor = .white
        addSubview(mainCreateView)
        addSubview(randomStickerImageView)
        mainCreateView.addSubview(supriseMeLabel)
        mainCreateView.addSubview(promptText)
        mainCreateView.addSubview(createButton)
        mainCreateView.addSubview(createButton)
        
        NSLayoutConstraint.activate([
            randomStickerImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            randomStickerImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            randomStickerImageView.widthAnchor.constraint(equalToConstant: 200),
            randomStickerImageView.heightAnchor.constraint(equalToConstant: 200),
            
            mainCreateView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -50),
            mainCreateView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainCreateView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainCreateView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            
            supriseMeLabel.centerXAnchor.constraint(equalTo: mainCreateView.centerXAnchor),
            supriseMeLabel.topAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.topAnchor,constant: 10),
            
            promptText.topAnchor.constraint(equalTo: supriseMeLabel.bottomAnchor,constant: 10),
            promptText.leadingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            promptText.trailingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            promptText.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.topAnchor.constraint(equalTo: promptText.bottomAnchor, constant: 5),
            createButton.leadingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            createButton.trailingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            
        ])
    }
}

