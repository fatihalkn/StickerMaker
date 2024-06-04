//
//  PayWallViewController.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import Foundation
import UIKit

class PayWallViewController: UIViewController {
    
    //MARK: - Properties
    var payWallView = PayWallView()
    
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = payWallView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payWallView.delegate = self
    }
}

//MARK: - PayWallViewProtocol
extension PayWallViewController: PayWallViewProtocol {
    func closeButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
