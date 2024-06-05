//
//  HomeViewModel.swift
//  StickerMaker
//
//  Created by Fatih on 29.05.2024.
//

import Foundation

class HomeViewModel {
    var rpStickerMakerRequestBodyModel = RPStickerMakerRequestBody(version: "4acb778eb059772225ec213948f0660867b2e03f277448f18cf1800b96a65a1a",
                                                                   input: .init(steps: 17,
                                                                                width: 512,
                                                                                height:512,
                                                                                prompt: "",
                                                                                outputFormat: "webp",
                                                                                outputQuality: 100,
                                                                                negativePrompt: "",
                                                                                numberOfImages: 1))
    
    var randomStickerImage: [RandomStickerModel] = [.init(stickerImage: "1"),
                                                    .init(stickerImage: "2"),
                                                    .init(stickerImage: "3"),
                                                    .init(stickerImage: "4"),
                                                    .init(stickerImage: "5")]
                                                    
    
    var supriseMeModel: [SupriseMeModel] = [.init(prompt: "A cute cat"),
                                            .init(prompt: "An angry penguin"),
                                            .init(prompt: "Pikachu, simple, clean"),
                                            .init(prompt: "Cute dragon"),
                                            .init(prompt: "A toxic yellow smiley face, X eyes")]
    
    func getStickerPhoto(completion: @escaping (RPGetManyResponse) -> Void) {
        NetworkManager.shared.getPredictionManyImage(requestBody: rpStickerMakerRequestBodyModel) { result in
            switch result {
            case .success(let success):
                completion(success)
                print("istek başarılı \(success)")
            case .failure(let failure):
                print("istek başarısız \(failure)")
            }
            
        }
    }
    
    func createButtonTapped(completion: @escaping (RPGetManyResponse) -> Void) {
        getStickerPhoto { responseModel in
            completion(responseModel)
        }
    }
}
