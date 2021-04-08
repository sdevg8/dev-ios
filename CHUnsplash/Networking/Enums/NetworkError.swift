//
//  NetworkError.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

enum NetworkError {
    case unknown
    case noJSONData
    
    var value: String {
        switch self {
        case .unknown:
            return "unknown"
        case .noJSONData:
            return "noJSONData"
        }
    }
}
