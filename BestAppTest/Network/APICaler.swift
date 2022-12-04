//
//  APICaler.swift
//  BestAppTest
//
//  Created by Карим Садыков on 29.11.2022.
//

import Foundation

enum APIError: Error {
    case failedTogetData
    
    var name: String {
        let error: String
        switch self{
        case .failedTogetData:
            error = "failedTogetData"
        }
        return error
    }
}

class APICaller {
    static let shared = APICaller()
    
    func getSearchPhoto(search: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let url = URL(string: "https://www.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(search)&nojsoncallback=1&") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
    
    func getPhoto(completion: @escaping (Result<[Item], Error>) -> Void) {

        guard let url = URL(string: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(DataModel.self, from: data)
                completion(.success(results.items))
                
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
}
