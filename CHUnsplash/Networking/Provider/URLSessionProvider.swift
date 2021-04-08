//
//  URLSessionProvider.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

import Foundation

final public class URLSessionProvider: ProviderProtocol {
    private var session: URLSessionProtocol
    init(_ session: URLSessionProtocol) {
        self.session = session
    }
    
    func request<T>(type: T.Type, service: ServiceProtocol, completion: @escaping (NetworkResponse<T>) -> ()) where T: Decodable {
        let request = URLRequest(service: service)
        
        let task = self.session.dataTask(request: request, completionHandler: { data, response, error in
            //guard let self = self else { return }
            let httpResponse = response as? HTTPURLResponse
            URLSessionProvider.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
        })
        task.resume()
    }
    
    private class func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (NetworkResponse<T>) -> ()) {
        guard error == nil else { return completion(.failure(.unknown)) }
        guard let response = response else { return completion(.failure(.noJSONData)) }
        
        switch response.statusCode {
        case 200...299:
            guard let data = data, let model = try? JSONDecoder().decode(T.self, from: data) else { return completion(.failure(.unknown)) }
            completion(.success(model))
        default:
            completion(.failure(.unknown))
        }
    }
}
