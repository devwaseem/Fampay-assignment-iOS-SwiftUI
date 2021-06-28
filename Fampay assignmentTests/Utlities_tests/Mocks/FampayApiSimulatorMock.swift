//
//  FampayApiSimulatorMock.swift
//  Fampay assignmentTests
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation
import Combine
@testable import Fampay_assignment

class FampayAPISimulatorMock: APISimulator {
    
    let data: Data
    
    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() {
        guard let path = Bundle(for: type(of: self)).path(forResource: "sample_response", ofType: "json")  else {
            fatalError("Sample response JSON file not found!")
        }
        
        do {
            self.data = try Data(contentsOf: URL(fileURLWithPath: path))
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
    }
    
    func fetch<T>(url: URL) -> AnyPublisher<T, NetworkError> where T : Decodable {
        Just(data)
            .decode(type: T.self, decoder: self.jsonDecoder)
            .mapError { error in
                NetworkError.invalidJSON(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
