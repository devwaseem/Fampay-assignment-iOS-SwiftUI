//
//  contextual_ card_models_decoder_tests.swift
//  Fampay assignmentTests
//
//  Created by Waseem Akram on 26/06/21.
//

import XCTest
import Combine
@testable import Fampay_assignment

class ContextualCardModelDecodingTest: XCTestCase {
    
    var cancellables: Set<AnyCancellable>!
    var api = FampayAPISimulatorMock()
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    func test_data_decode() throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode([String].self, from: api.data)
        XCTAssertNotNil(result)
        print(result)
    }
    
    
    func test_api_simulator_correctly_decodes_model() {
        
        let expectation = expectation(description: "Decoding contextual card group model from json data")
        var cardGroup: [ContextualCardGroup]?
        var networkError: NetworkError?
        
        let dataPublisher: AnyPublisher<[ContextualCardGroup], NetworkError> = FampayAPISimulator.shared.fetch(url: URL(string: "http://www.mocky.io/v2/5ed79368320000a0cc27498b")!)
        dataPublisher.sink { completion in
            if case let .failure(error) = completion {
                networkError = error
            }
            expectation.fulfill()
        } receiveValue: { result in
            cardGroup = result
        }.store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
        
        XCTAssertNil(networkError)
        XCTAssertNotNil(cardGroup)

    }
    
}

