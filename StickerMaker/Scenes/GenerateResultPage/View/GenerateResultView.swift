//
//  GenerateResultView.swift
//  StickerMaker
//
//  Created by Fatih on 3.06.2024.
//

import Foundation
import UIKit
import SDWebImage
import SDWebImageWebPCoder
import Photos

protocol GenerateResultViewProtocol {
    func closeGenareteResultViewController()
    func shareButtonClicked()
}
final class GenerateResultView: UIView {
    
    //MARK: - Properties
    var generatePageViewModel = GenerateResultPageViewModel()
    var delegate: GenerateResultViewProtocol?
    
    //MARK: - UI Elements
    lazy var resultStickerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .mainCreateView
        image.image = ._1
        return image
    }()
    
    lazy var copyButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.on.doc.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var saveButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 0.8
        button.layer.borderColor = UIColor.blue.cgColor
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var closePageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .mainCreateView
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
        setupButtonTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonTargets() {
        closePageButton.addTarget(self, action: #selector(closePageButtonTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func closePageButtonTapped() {
        delegate?.closeGenareteResultViewController()
    }
    
    @objc func shareButtonTapped() {
        delegate?.shareButtonClicked()
    }
    
    @objc func copyButtonTapped() {
        UIPasteboard.general.image = resultStickerImage.image
        copyButton.setTitle("Copy", for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            self.copyButton.setTitle("Copy", for: .normal)
            self.showSucceed(text: "Sticker copied", interaction: false, delay: 2)
        }
    }
    
    @objc func saveButtonTapped() {
        guard let resultStickerImage = resultStickerImage.image else { return }
        saveImageToGallery(image: resultStickerImage)
        self.showSucceed(text: "The sticker has been successfully saved to your gallery!", interaction: false, delay: 2)
    }
    
    func saveImageToGallery(image: UIImage, completion: ((_ success: Bool) -> Void)? = nil) {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            completion?(false)
            return
        }
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: UIImage(data: imageData)!)
        } completionHandler: { success, error in
            completion?(success)
        }
    }
}





//MARK: - SetupUI
private extension GenerateResultView {
    func setupRadius() {
        resultStickerImage.layer.cornerRadius = 12
        resultStickerImage.layer.masksToBounds = true
        
        closePageButton.layer.cornerRadius = closePageButton.frame.height / 2
        closePageButton.layer.masksToBounds = true
    }
    
    func setupUI() {
        backgroundColor = .white
        addSubview(resultStickerImage)
        addSubview(copyButton)
        addSubview(saveButton)
        addSubview(shareButton)
        addSubview(closePageButton)
        addSubview(copyButtonImageView)
        addSubview(saveButtonImageView)
        
        NSLayoutConstraint.activate([
            
            closePageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            closePageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 15),
            closePageButton.widthAnchor.constraint(equalToConstant: 30),
            closePageButton.heightAnchor.constraint(equalToConstant: 30),
            
            shareButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            resultStickerImage.topAnchor.constraint(equalTo: closePageButton.bottomAnchor, constant: 20),
            resultStickerImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            resultStickerImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            resultStickerImage.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            
            copyButton.topAnchor.constraint(equalTo: resultStickerImage.bottomAnchor, constant: 30),
            copyButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            copyButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            copyButton.heightAnchor.constraint(equalToConstant: 50),
            
            copyButtonImageView.topAnchor.constraint(equalTo: copyButton.topAnchor,constant: 10),
            copyButtonImageView.centerXAnchor.constraint(equalTo: copyButton.centerXAnchor,constant: 40),
            copyButtonImageView.heightAnchor.constraint(equalToConstant: 30),
            
            saveButton.topAnchor.constraint(equalTo: copyButton.bottomAnchor, constant: 15),
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            saveButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            saveButtonImageView.topAnchor.constraint(equalTo: saveButton.topAnchor, constant: 10),
            saveButtonImageView.centerXAnchor.constraint(equalTo: saveButton.centerXAnchor,constant: 40),
            saveButtonImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
