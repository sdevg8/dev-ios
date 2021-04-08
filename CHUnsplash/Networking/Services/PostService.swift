//
//  PostService.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

import Foundation

enum PostService: ServiceProtocol {
    
    case albums
    case photos(albumId: Int)
    
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .albums:
            return "albums"
        case .photos:
            return "photos"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: Task {
        switch self {
        case .albums:
            return .requestPlain
        case let .photos(albumId):
            let parameters = ["albumId": albumId]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return nil
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
