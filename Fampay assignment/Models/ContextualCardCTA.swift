//
//  ContextualCardCTA.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation

struct ContextualCardCTA: Decodable, Identifiable {
    var id = UUID()
    let text: String
    let backgroundColor: HexColor?
    let url: URL?
    let textColor: HexColor?
    
    enum CodingKeys: String, CodingKey {
        case text, url, textColor
        case backgroundColor = "bgColor"
    }
}
