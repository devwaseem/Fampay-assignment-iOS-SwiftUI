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
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func fetch<T: Decodable>(url:URL) -> AnyPublisher<T, NetworkError> {
        let request = URLRequest(url: url)
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: self.jsonDecoder)
            .mapError { error in
                NetworkError.invalidJSON(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    
}
