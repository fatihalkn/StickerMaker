//
//  GnerateResultPage.swift
//  StickerMaker
//
//  Created by Fatih on 3.06.2024.
//

import Foundation
import UIKit

class GenerateResultPage: UIViewController {
    
    //MARK: - Properties
    let generateResultView = GenerateResultView()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = generateResultView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateResultView.delegate = self
    }
}

//MARK: - GenerateResultViewProtocol
extension GenerateResultPage: GenerateResultViewProtocol {
    func shareButtonClicked() {
        guard let imageToShare = generateResultView.resultStickerImage.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    func closeGenareteResultViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
