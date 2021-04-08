//
//  ProviderProtocol.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

protocol ProviderProtocol {
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable
}
