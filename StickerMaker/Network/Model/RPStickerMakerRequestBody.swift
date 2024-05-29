//
//  RPStickerMakerRequestBody.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation

// MARK: - RPStickerMakerRequestBody
struct RPStickerMakerRequestBody: Codable {
    let version: String?
    var input: RPStickerMakerInput?
}

// MARK: - Input
struct RPStickerMakerInput: Codable {
    let steps, width, height: Int?
    var prompt, outputFormat: String?
    let outputQuality: Int?
    let negativePrompt: String?
    let numberOfImages: Int?

    enum CodingKeys: String, CodingKey {
        case steps, width, height, prompt
        case outputFormat = "output_format"
        case outputQuality = "output_quality"
        case negativePrompt = "negative_prompt"
        case numberOfImages = "number_of_images"
    }
}
