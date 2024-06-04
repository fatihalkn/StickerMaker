//
//  SettingsElementsCell.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import UIKit

class SettingsElementsCell: UITableViewCell {
    static let identifier = "SettingsElementsCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupFrame()

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsItem) {
        label.text = model.title
        iconImageView.image = model.image
        iconContainer.backgroundColor = model.iconBackRoundColor
    }
    
    func setupFrame() {
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15,
                                     y: 6,
                                     width: size,
                                     height: size)
        
        let imageSize: CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize) / 2,
                                     y: (size - imageSize) / 2,
                                     width: imageSize,
                                     height: imageSize)
        
        label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 25 - iconContainer.frame.size.width ,
                             height: contentView.frame.size.height)
    }
    
}
