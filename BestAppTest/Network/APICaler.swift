//
//  APICaler.swift
//  BestAppTest
//
//  Created by Карим Садыков on 29.11.2022.
//

import Foundation

struct Constants {
    static let API_KEY = "838b09c42fbd7f6b6d3284f23d241065"
    static let baseURL = "https://www.flickr.com/services/feeds/photos_public.gne?"
    static let random = "random"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getPhoto(search: String, num: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)format=json&tags=\(search)&nojsoncallback=1&per_page=\(num)") else { return }
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
