//
//  PhotoEndpoint.swift
//  BestAppTest
//
//  Created by Карим Садыков on 29.11.2022.
//

import Foundation

enum GifsEndpoint {
    case trending
    case categories
    case search(String)
}

extension GifsEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .trending:
            return "/v1/gifs/trending"
        case .categories:
            return "/v1/gifs/categories"
        case .search:
            return "/v1/gifs/search"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let queryParameter):
            return [
                URLQueryItem(name: "q", value: queryParameter)
            ]
        default: return []
        }
    }
    
    var header: [HTTPHeader]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
    
}

