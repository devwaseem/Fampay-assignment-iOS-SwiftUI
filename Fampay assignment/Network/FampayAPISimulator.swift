//
//  APISimulator.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Combine
import Foundation

public final class FampayAPISimulator: APISimulator {
    
    private init(){}
    
    public static let shared = FampayAPISimulator()
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        // to test the mock server with different responses, we ignore the local and remote cache
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return URLSession(configuration: configuration)
    }()
    
    func fetch<T: Decodable>(url:URL) -> AnyPublisher<T, NetworkError> {
        let request = URLRequest(url: url)
        return session
            .dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                
                guard let response = output.response as? HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Something went wrong while fetching the resource")
                }
                
                if (200 ..< 300 ~= response.statusCode) {
                    return output.data
                }
                
                throw NetworkError.badRequest(code: response.statusCode, error: response.description)
            }
            .decode(type: T.self, decoder: self.jsonDecoder)
            .mapError { error in
                NetworkError.invalidJSON(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    
}
