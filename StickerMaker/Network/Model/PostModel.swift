//
//  PostModel.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation

// MARK: - RPPostResponse
struct RPPostResponse: Codable {
    let id, model, version: String?
    let input: RPPostResponseInput?
    let urls: RPPostResponseInputUrls?

    enum CodingKeys: String, CodingKey {
        case id, model, version, input
        case urls
    }
}

// MARK: - Input
struct RPPostResponseInput: Codable {
    let img: String?
    let scale: Int?
    let version: String?
}

// MARK: - Urls
struct RPPostResponseInputUrls: Codable {
    let cancel, get: String?
}
