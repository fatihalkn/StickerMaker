//
//  DirectoryView.swift
//  StickerMaker
//
//  Created by Fatih on 5.06.2024.
//

import Foundation
import UIKit

protocol DirectoryViewProtocol {
    func closeButton()
}

class DirectoryView:UIView {
    
    //MARK: - Properties
    var directoryViewModel = DirectoryViewModel()
    var delegate: DirectoryViewProtocol?
    
    //MARK: - UI Elements
    lazy var closePageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.backgroundColor = .mainCreateView
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How to Create Sticker?"
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directoryTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        addTarget()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        closePageButton.layer.cornerRadius = closePageButton.frame.height / 2
        closePageButton.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addTarget() {
        closePageButton.addTarget(self, action: #selector(buttonCliced), for: .touchUpInside)
    }
    
    @objc func buttonCliced() {
        delegate?.closeButton()
    }
}

//MARK: - SetupUI
extension DirectoryView {
    
    func setupUI() {
        addSubview(closePageButton)
        addSubview(titleLabel)
        addSubview(directoryTableView)
        setupRegister()
        setupDelegate()
        
        NSLayoutConstraint.activate([
            closePageButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,constant: 15),
            closePageButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 30),
            closePageButton.heightAnchor.constraint(equalToConstant: 30),
            closePageButton.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: closePageButton.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo:safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            directoryTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            directoryTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            directoryTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            directoryTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//MARK: - Configure TableView
extension DirectoryView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        directoryViewModel.explanations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DirectoryTableViewCell.idetifier, for: indexPath) as! DirectoryTableViewCell
        let model = directoryViewModel.explanations[indexPath.row].explanations
        cell.textLabel?.text = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func setupRegister() {
        directoryTableView.register(DirectoryTableViewCell.self, forCellReuseIdentifier: DirectoryTableViewCell.idetifier)
    
    }
    
    func setupDelegate() {
        directoryTableView.delegate = self
        directoryTableView.dataSource = self
    }
}
