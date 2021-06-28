//
//  DesignTypes.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation


enum ContextualCardDesignTypes: String, Decodable {
    case smallDisplayCard = "HC1"
    case bigDisplayCard = "HC3"
    case imageCard = "HC5"
    case smallCardWithArrow = "HC6"
    case dynamicWidthCard = "HC9"
    case unsupported
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let designType = try container.decode(String.self)
        if let validDesignType = ContextualCardDesignTypes(rawValue: designType) {
            self = validDesignType
        } else {
            self = .unsupported
        }
    }
}
