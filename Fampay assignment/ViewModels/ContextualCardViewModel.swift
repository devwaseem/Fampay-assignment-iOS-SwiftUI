//
//  BigDisplayContextualCardViewModel.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI
import Combine

class ContextualCardViewModel: ObservableObject {
    
    var bigDisplayCardReminderRepo: BigDisplayCardIgnoringListRepository
    
    @Published var isRefreshing = false
    @Published var isAlertPresenting = false
    @Published var alertTitle = ""
    @Published var cardGroups: [ContextualCardGroup]?
    
    private var sessionIgnoredCardIdList = [Int]()
    private var cancellables: Set<AnyCancellable> = []
    
    init(bigDisplayCardReminderRepo: BigDisplayCardIgnoringListRepository) {
        self.bigDisplayCardReminderRepo = bigDisplayCardReminderRepo
    }
    
    func fetchCardsGroup() {
        self.isRefreshing = true
        let mockApiUrl = URL(string: "http://www.mocky.io/v2/5ed79368320000a0cc27498b")!
        let cardGroupPublisher: AnyPublisher<[ContextualCardGroup], NetworkError> = FampayAPISimulator.shared
            .fetch(url: mockApiUrl)
        
        cardGroupPublisher
            .mapError(AnyError.init(error:)) // Type erasing the error since we don't need the specific type
            .zip(bigDisplayCardReminderRepo.getAll()
                    .replaceError(with: []) // This is subjective, I decided to not show errors related to Coredata.
                    .eraseToAnyPublisher()
                    .mapError(AnyError.init(error:)) // Type erasing even though it will not execute to match the Upstream Type
            )
            .map { (cardGroupsResult, ignoringCardIdList) in
                cardGroupsResult.filter {
                    // should not contain in session ignoring list and the permanent ignoring list
                    !ignoringCardIdList.map(\.id).contains(Int64($0.id)) && !self.sessionIgnoredCardIdList.contains($0.id)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink { result in
                
                self.isRefreshing = false
                switch result {
                case.failure(let error):
                    self.alertTitle = error.localizedDescription
                    self.isAlertPresenting = true
                case .finished:
                    self.alertTitle = ""
                }
                
            } receiveValue: { result in
                
                self.cardGroups = result
                
            }.store(in: &cancellables)
    }
    
    func remindLaterBigDisplayCard(id: Int) {
        sessionIgnoredCardIdList.append(id)
        cardGroups = cardGroups?.filter{ $0.id != id }
    }
    
    func dismissBigDisplaycard(id: Int) {
        bigDisplayCardReminderRepo.insert(id: id)
            .sink { result in
                switch result {
                case .failure(let error):
                    self.alertTitle = error.localizedDescription
                    self.isAlertPresenting = true
                default:
                    break
                }
            } receiveValue: { _ in
                self.cardGroups = self.cardGroups?.filter { $0.id != id }
            }
            .store(in: &cancellables)

    }
    
}
