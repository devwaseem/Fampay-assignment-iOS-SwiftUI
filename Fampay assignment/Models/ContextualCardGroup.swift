//
//  CardGroup.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation

struct ContextualCardGroup: Decodable, Identifiable {
    var id = UUID()
    let designType: ContextualCardDesignTypes
    let name: String
    let height: Int?
    let isScrollable: Bool
    let cards: [ContextualCard]?
    
    enum CodingKeys: String, CodingKey {
        case designType, name, height, isScrollable, cards
    }
}
