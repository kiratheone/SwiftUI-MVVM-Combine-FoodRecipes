//
//  ApiClient.swift
//  foodrecipes
//
//  Created by Arik on 26/05/20.
//  Copyright © 2020 Arik. All rights reserved.
//

import Foundation
import Combine

struct Resource {
    let url: URL
    let method: String = "GET"
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIClientError: Error {
    case noData
}


extension URLRequest {
    
    init(_ resource: Resource) {
        self.init(url: resource.url)
        self.httpMethod = resource.method
    }
    
}

final class ApiClient {
    
    func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let `data` = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let `error` = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
    func load<T: Decodable>(_ resource: Resource) -> AnyPublisher<T, Error> {
        let request = URLRequest(resource)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map{ $0.data }
            .handleEvents(receiveOutput: {
                print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
