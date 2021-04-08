//
//  NetworkResponse.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

enum NetworkResponse<T> {
    case success(T)
    case failure(NetworkError)
}
