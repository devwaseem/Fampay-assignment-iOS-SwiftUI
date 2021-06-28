//
//  CardGroup.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation

struct ContextualCardGroup: Decodable {
    let designType: ContextualCardDesignTypes
    let name: String
    let height: Int?
    let isScrollable: Bool
    let cards: [ContextualCard]?
}
