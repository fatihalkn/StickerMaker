//
//  SettingsModel.swift
//  StickerMaker
//
//  Created by Fatih on 4.06.2024.
//

import Foundation
import UIKit

struct SettingsItem {
    let title: String
    let image: UIImage
    let iconBackRoundColor: UIColor
    let handler: (() -> Void)
    
}

struct Sections {
    let title: String
    let settigns: [SettingsItem]
}

