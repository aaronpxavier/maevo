//
//  APIBase.swift
//  maevo
//
//  Created by Aaron Xavier on 10/25/22.
//


import Foundation
import Combine

enum ServiceError: Error {
    case clientError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
}


class APIBase {
    
    private let session = URLSession.shared
    var cancellables = Set<AnyCancellable>()
    
    func getRequestAsync<T: Decodable>(urlComps: URLComponents) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: urlComps.url!)
            .tryMap { element  in
                if let httpResponse = element.response as? HTTPURLResponse {
                    let httpCode = httpResponse.statusCode
                    #if DEBUG
                    print("\nHTTP GET\nTime: \(Date())\nURL: \(urlComps.url!)\(urlComps.path)\nResponseCode: \(httpCode)\n")
                    #endif
                    switch(httpCode) {
                    case(200..<300):
                        do {
                            let value = try JSONDecoder().decode(T.self, from: element.data)
                            #if DEBUG
                                print(value)
                            #endif
                            return value
                        } catch {
                            print(error)
                            throw error
                        }
                    case(400..<500):
                        throw ServiceError.clientError(httpCode)
                        
                    default:
                        throw ServiceError.serverError(httpCode)
                    }
                }
                throw ServiceError.clientError(0)
            }
            .eraseToAnyPublisher()
    }
}
