//
//  SettingsView.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import Foundation
import UIKit

protocol SettingsViewProtocol {
    func clickedShareApp()
    func clickedSendFeedBack()
}

class SettingsView: UIView {
    
    //MARK: - Properties
    var settingsViewModel = SettingsViewModel()
    var delegate: SettingsViewProtocol?
    //MARK: - UI Elements
    private let settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        return tableView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configure()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

//MARK: - Configure TableView
extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func configure() {
        settingsViewModel.settingsData.append(Sections(title: "PREMİUM", settigns: [
            .init(title: "STCKR PRO", image: .stckr, iconBackRoundColor: .darkGray, handler: {
                //PAYWALL AÇTIR
            }),
            .init(title: "Restore Purchases", image: .restore, iconBackRoundColor: .systemBlue, handler: {
                let websiteURL = URL(string: "https://github.com/fatihalkn")
                if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                } else {
                    print("Geçersiz URL veya Açılmayan URL")
                }
            })
        ]))
        
        settingsViewModel.settingsData.append(Sections(title: "SUPPORT", settigns: [
            .init(title: "Send Feedback", image: .sendFeedBack, iconBackRoundColor: .systemPink, handler: {
                self.delegate?.clickedSendFeedBack()
                
            }),
            .init(title: "Write a Review", image: .writeReview, iconBackRoundColor: .systemBlue, handler: {
                let websiteURL = URL(string: "https://github.com/fatihalkn")
                if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                } else {
                    print("Geçersiz URL veya Açılmayan URL")
                }
            }),
            .init(title: "Follow us on X", image: .followX, iconBackRoundColor: .systemRed, handler: {
                let websiteURL = URL(string: "https://github.com/fatihalkn")
                if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                } else {
                    print("Geçersiz URL veya Açılmayan URL")
                }
            }),
            .init(title: "Share App", image: .share, iconBackRoundColor: .systemMint, handler: {
                self.delegate?.clickedShareApp()
            })
        ]))
        
        settingsViewModel.settingsData.append(Sections(title: "APP DETAILS", settigns: [
            .init(title: "Privacy Policy", image: UIImage(systemName: "globe")!, iconBackRoundColor: .systemPink, handler: {
                let websiteURL = URL(string: "https://www.termsfeed.com/public/uploads/2021/12/sample-mobile-app-terms-conditions-template.pdf")
                if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                } else {
                    print("Geçersiz URL veya Açılmayan URL")
                }
            }),
            .init(title: "Term of Use", image: UIImage(systemName: "globe")!, iconBackRoundColor: .systemBlue, handler: {
                let websiteURL = URL(string: "https://www.termsfeed.com/public/uploads/2021/12/sample-mobile-app-terms-conditions-template.pdf")
                if let url = websiteURL, UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:],completionHandler: nil)
                } else {
                    print("Geçersiz URL veya Açılmayan URL")
                }
            })
        ]))
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = settingsViewModel.settingsData[section]
        return section.title
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingsViewModel.settingsData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsViewModel.settingsData[section].settigns.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: SettingsElementsCell.identifier, for: indexPath) as! SettingsElementsCell
        let settingsItem = settingsViewModel.settingsData[indexPath.section].settigns[indexPath.row]
        cell.configure(with: settingsItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemType = settingsViewModel.settingsData[indexPath.section].settigns[indexPath.row]
        itemType.handler()
    }
    
    
}

//MARK: - SetupUI
extension SettingsView {
    
    func setupUI() {
        setupDelegates()
        setupRegister()
        addSubview(settingsTableView)
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func setupRegister() {
        settingsTableView.register(SettingsElementsCell.self, forCellReuseIdentifier: SettingsElementsCell.identifier)
    }
    
    func setupDelegates() {
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
}
