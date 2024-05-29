//
//  NetworkManager.swift
//  StickerMaker
//
//  Created by Fatih on 22.05.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    var pollTimer: Timer?
    
    func getPredictionManyImage(requestBody: RPStickerMakerRequestBody, completion: @escaping (Result<RPGetManyResponse, Error>) -> Void) {
        NetworkManager.shared.createPrediction(requestBody: requestBody) { result in
            switch result {
            case .success(let response):
                guard let predictiponGetIDPath = response.id else {
                    completion(.failure(NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "Nil Prediction GET ID"])))
                    return
                }
                
                self.pollManyImagePrediction(for: predictiponGetIDPath, completion: completion)
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func pollManyImagePrediction(for predictionGetIdPath: String, completion: @escaping (Result<RPGetManyResponse, Error>) -> Void) {
        pollTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.getPredictionResponse(for: predictionGetIdPath) { getResult in
                switch getResult {
                case .success(let response):
                    if let status = response.status {
                        switch status {
                        case .starting:
                            break
                        case .processing:
                            break
                        case .succeeded:
                            self.pollTimer?.invalidate()
                            self.pollTimer = nil
                            
                            completion(.success(response))
                        case .failed:
                            self.pollTimer?.invalidate()
                            self.pollTimer = nil
                            completion(.failure((NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "Poll is failed"]))))
                        case .canceled:
                            self.pollTimer?.invalidate()
                            self.pollTimer = nil
                            completion(.failure((NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "Request is camceşşed"]))))
                        }
                        
                    } else {
                        self.pollTimer?.invalidate()
                        self.pollTimer = nil
                        
                        completion(.failure((NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "Status is Nil"]))))
                    }
                case .failure(let failure):
                    self.pollTimer?.invalidate()
                    self.pollTimer = nil
                    
                    completion(.failure(failure))
                }
            }
        })
    }
    
    private func getPredictionResponse(for predictionGetIdPath: String, completion: @escaping (Result<RPGetManyResponse, Error>) -> Void) {
        let url = "https://api.replicate.com/v1/predictions/\(predictionGetIdPath)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer 1"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
                    do {
                        let decodedData = try JSONDecoder().decode(RPGetManyResponse.self, from: jsonData)
                        print("decodedData = \(decodedData)")
                        completion(.success(decodedData))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                    
                } else {
                    completion(.failure(NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "INVALID JSON DATA"])))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func createPrediction(requestBody: RPStickerMakerRequestBody, completion: @escaping(Result<RPPostResponse, Error>) -> Void) {
        let url = "https://api.replicate.com/v1/predictions"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer 1"
        ]
        
        AF.request(url, method: .post, parameters: requestBody, encoder: JSONParameterEncoder.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let jsonData = try? JSONSerialization.data(withJSONObject: data) {
                    do {
                        let decodedData = try JSONDecoder().decode(RPPostResponse.self, from: jsonData)
                        print("decodedData = \(decodedData)")
                        completion(.success(decodedData))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                    
                } else {
                    completion(.failure(NSError(domain: "com.stickerMaker", code: 1, userInfo: [NSLocalizedDescriptionKey: "INVALID JSON DATA"])))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
