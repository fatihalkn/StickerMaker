//
//  DirectoryViewController.swift
//  StickerMaker
//
//  Created by Fatih on 5.06.2024.
//

import Foundation
import UIKit

class DirectoryViewController: UIViewController {
    
    //MARK: - Properties
    var directoryVies = DirectoryView()
    //MARK: - Life Cycle Methods
    override func loadView() {
        super.loadView()
        view = directoryVies
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        directoryVies.delegate = self
    }
}

//MARK: - DirectoryViewProtocol
extension DirectoryViewController: DirectoryViewProtocol {
    func closeButton() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
