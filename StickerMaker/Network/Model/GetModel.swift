//
//  GetModel.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation

// MARK: - RPGetManyResponse
struct RPGetManyResponse: Codable {
    let completedAt, createdAt: String?
    let id: String?
    let logs: String?
    let output: [String]?
    let startedAt: String?
    let urls: RPGetManyResponseUrls?
    let status: RPGetResponseStatus?
    let version: String?

    enum CodingKeys: String, CodingKey {
        case completedAt = "completed_at"
        case createdAt = "created_at"
        case id, logs, output
        case startedAt = "started_at"
        case status, urls, version
    }
}

enum RPGetResponseStatus: String, Codable {
    case starting
    case processing
    case succeeded
    case failed
    case canceled
}

// MARK: - Urls
struct RPGetManyResponseUrls: Codable {
    let urlsGet, cancel: String?

    enum CodingKeys: String, CodingKey {
        case urlsGet = "get"
        case cancel
    }
}
