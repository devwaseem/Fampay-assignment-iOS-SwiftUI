//
//  APISimulator.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation
import Combine

protocol APISimulator {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, NetworkError>
}
