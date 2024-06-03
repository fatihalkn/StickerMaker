//
//  HomeViewController.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - Properties
    private let homeView = HomeView()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        homeView.delegate = self
    }
}

//Mark: - NavigationBar
extension HomeViewController {
    func setupNavigationBar() {
        makeOpaqueNavBar(backgroundColor: .mainCreateView)
        navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = "STCKR"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: .questionMark, style: .done, target: nil, action: nil)
        let proButton = UIBarButtonItem(image: UIImage(systemName: "star.square.on.square.fill"), style: .done, target: nil, action: nil)
        let settignsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: nil, action: nil)
        self.navigationItem.rightBarButtonItems = [proButton, settignsButton]
        
    }
}

//MARK: - HomeViewDelegate
extension HomeViewController: HomeViewProtocol {
    func presentGenarateResultPage(imageData: Data) {
        let vc = GenerateResultPage()
        vc.generateResultView.resultStickerImage.image = UIImage(data: imageData)
        navigationController?.present(vc, animated: true)
    }
  
    
}