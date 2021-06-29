//
//  BigDisplayContextualCardViewModel.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI
import Combine

class ContextualCardViewModel: ObservableObject {
    
    @Published var isRefreshing = false
    @Published var isAlertPresenting = false
    @Published var alertTitle = ""
    @Published var cardGroups: [ContextualCardGroup]?
    
    var cancellables: Set<AnyCancellable> = []
    
    func fetchCardsGroup() {
        print("fetching")
        self.isRefreshing = true
        let mockApiUrl = URL(string: "http://www.mocky.io/v2/5ed79368320000a0cc27498b")!
        let cardGroupPublisher: AnyPublisher<[ContextualCardGroup], NetworkError> = FampayAPISimulator.shared
            .fetch(url: mockApiUrl)
        
        cardGroupPublisher
            .receive(on: DispatchQueue.main)
            .map {
                // $0 -> the data received is an array, so we map and filter
                $0.filter {
                    $0.designType != .unsupported // remove the unsupported card types
                }
            }
            .sink { result in
                
                self.isRefreshing = false
                switch result {
                case.failure(let error):
                    self.alertTitle = error.localizedDescription
                    self.isAlertPresenting = true
                case .finished:
                    print("finished")
                    self.alertTitle = ""
                }
                
            } receiveValue: { result in
                
                self.cardGroups = result
                
            }.store(in: &cancellables)
    }
    
    
}
