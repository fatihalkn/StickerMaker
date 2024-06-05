//
//  HomeView.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation
import UIKit
import SDWebImage
import SDWebImageWebPCoder

protocol HomeViewProtocol {
    func presentGenarateResultPage(imageData: Data)
}

final class HomeView: UIView {
    
    //MARK: - Properties
    var homeViewModel = HomeViewModel()
    var currentIndex = 0
    var timer: Timer?
    var fastTimer: Timer?
    var delegate: HomeViewProtocol?
    var isTimerStarted = false
    
    //MARK: - UI Elements
    lazy var mainCreateView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainCreateView
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dibbingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var creatingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var randomStickerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
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
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = .always
        textField.placeholder = "Write Something"
        textField.backgroundColor = .textField
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.2
        textField.font = .systemFont(ofSize: 12, weight: .bold)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var supriseMeButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSAttributedString(string: "Suprise Me",attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 20)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .red
        return indicator
    }()
    
    lazy var supriseMeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.image = .supriseMe
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addButtonTargets()
        randomStickerImageView.image = UIImage(named: homeViewModel.randomStickerImage[currentIndex].stickerImage)
        startTimer()
        promptText.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureWebpImage(data: Data) {
        let image = UIImage(data: data)
        randomStickerImageView.image = image
        
        if let path = Bundle.main.path(forResource: "image", ofType: "webp") {
            let localUrl = URL(fileURLWithPath: path)
            randomStickerImageView.sd_setImage(with: localUrl, completed: nil)
        }
    }
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        isTimerStarted = true
    }
    
    func loadingTimer() {
        fastTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
    }
    
    func stopFastTimer() {
        fastTimer?.invalidate()
        fastTimer = nil
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerStarted = false
    }
    
    @objc func changeImage() {
        currentIndex = (currentIndex + 1) % homeViewModel.randomStickerImage.count
        let nextImageName = homeViewModel.randomStickerImage[currentIndex].stickerImage
        UIView.transition(with: randomStickerImageView,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
            self.randomStickerImageView.image = UIImage(named: nextImageName)
        },
                          completion: nil)
    }
    
    func startViewAnimation() {
        UIView.animate(withDuration: 5.0) {
            self.dibbingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        }
    }
    
    func stopDibbingAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.dibbingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        }
    }
    
    func checkDibbingAnimation() {
        if self.dibbingView.alpha >= 0.7 {
            stopDibbingAnimation()
        }
    }
}

//MARK: - TextFieldDelegate
extension HomeView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string), 
            newText.isEmpty {
            if !isTimerStarted {
                startTimer()
            }
            self.dibbingView.backgroundColor = .white
        }
        return true
    }
}

//MARK: - Button Targests
private extension HomeView {
    func addButtonTargets() {
        createButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        supriseMeButton.addTarget(self, action: #selector(supriseMeButtonTapped), for: .touchUpInside)
    }
    
    @objc func supriseMeButtonTapped() {
        if let randomElemnt = homeViewModel.supriseMeModel.randomElement() {
            promptText.text = randomElemnt.prompt
        } else {
            promptText.text = "A near fatal hot chocolate accident."
        }
    }
    
    @objc func buttonTapped() {
        guard let promtText = promptText.text, !promtText.isEmpty else {
            self.mainCreateView.shake()
            self.supriseMeButton.shake()
            self.promptText.shake()
            self.createButton.shake()
            showError(text: "Please Write Something Before Creating", image: UIImage(systemName: "xmark.seal"), interaction: false, delay: 1)
            print("text boş istek atılmadı")
            return
        }
        homeViewModel.rpStickerMakerRequestBodyModel.input?.prompt = promtText
        print(promptText.text ?? "boş")
        loadingTimer()
        startViewAnimation()
        activityIndicator.startAnimating()
        homeViewModel.createButtonTapped { generateModel in
            let imgUrl = generateModel.output?.first ?? ""
            if let url = URL(string: imgUrl) {
                let reqeust = URLRequest(url: url)
                URLSession.shared.dataTask(with: reqeust) { data, response, error in
                    if  error != nil || data == nil {
                        // hata göster kullanıcıya
                        return
                    }
                    
                    if let data {
                        DispatchQueue.main.async {
                            self.configureWebpImage(data: data)
                            self.stopFastTimer()
                            self.stopTimer()
                            self.activityIndicator.stopAnimating()
                            self.checkDibbingAnimation()
                            self.delegate?.presentGenarateResultPage(imageData: data)
                        }
                    }
                }.resume()
                
            }
        }
    }
}

//MARK: - SetupUI
private extension HomeView {
    
    func setupRadius() {
        mainCreateView.layer.cornerRadius = 8
        mainCreateView.layer.masksToBounds = true
        
        promptText.layer.cornerRadius = 8
        promptText.layer.masksToBounds = true
        
        createButton.layer.cornerRadius = 8
        createButton.layer.masksToBounds  = true
        
        randomStickerImageView.layer.cornerRadius = randomStickerImageView.frame.height / 2
        randomStickerImageView.layer.masksToBounds = true
        
        creatingView.layer.cornerRadius = creatingView.frame.height / 2
        creatingView.layer.masksToBounds = true
    }
    func setupUI() {
        backgroundColor = .white
        addSubview(dibbingView)
        addSubview(mainCreateView)
        addSubview(creatingView)
        creatingView.addSubview(randomStickerImageView)
        creatingView.addSubview(activityIndicator)
        mainCreateView.addSubview(supriseMeButton)
        mainCreateView.addSubview(promptText)
        mainCreateView.addSubview(createButton)
        mainCreateView.addSubview(createButton)
        mainCreateView.addSubview(supriseMeImageView)
        
        NSLayoutConstraint.activate([
            randomStickerImageView.centerYAnchor.constraint(equalTo: creatingView.centerYAnchor),
            randomStickerImageView.centerXAnchor.constraint(equalTo: creatingView.centerXAnchor),
            randomStickerImageView.widthAnchor.constraint(equalToConstant: 250),
            randomStickerImageView.heightAnchor.constraint(equalToConstant: 250),
            
            creatingView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 30),
            creatingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            creatingView.widthAnchor.constraint(equalToConstant: 300),
            creatingView.heightAnchor.constraint(equalToConstant: 300),
            
            dibbingView.topAnchor.constraint(equalTo: self.topAnchor),
            dibbingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dibbingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dibbingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
    
            activityIndicator.topAnchor.constraint(equalTo: randomStickerImageView.bottomAnchor,constant: -40),
            activityIndicator.leadingAnchor.constraint(equalTo: randomStickerImageView.leadingAnchor,constant: 30),
            activityIndicator.trailingAnchor.constraint(equalTo: randomStickerImageView.trailingAnchor, constant: -30),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            
            mainCreateView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,constant: -50),
            mainCreateView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainCreateView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainCreateView.heightAnchor.constraint(greaterThanOrEqualToConstant: 150),
            
            
            supriseMeButton.centerXAnchor.constraint(equalTo: mainCreateView.centerXAnchor),
            supriseMeButton.topAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.topAnchor,constant: 10),
            
            supriseMeImageView.centerYAnchor.constraint(equalTo: supriseMeButton.centerYAnchor),
            supriseMeImageView.leadingAnchor.constraint(equalTo: supriseMeButton.trailingAnchor,constant: 10),
            supriseMeImageView.heightAnchor.constraint(equalToConstant: 25),
            supriseMeImageView.widthAnchor.constraint(equalToConstant: 25),
            
            
            
            promptText.topAnchor.constraint(equalTo: supriseMeButton.bottomAnchor,constant: 10),
            promptText.leadingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            promptText.trailingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            promptText.heightAnchor.constraint(equalToConstant: 50),
            
            createButton.topAnchor.constraint(equalTo: promptText.bottomAnchor, constant: 5),
            createButton.leadingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            createButton.trailingAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            createButton.bottomAnchor.constraint(equalTo: mainCreateView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            createButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}

