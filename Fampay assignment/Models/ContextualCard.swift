//
//  ContextualCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation
import SwiftUI

struct ContextualCard: Decodable {
    
    let name: String
    let formattedTitle: CTXCardFormattedText?
    let fallbackTitle: String?
    let formattedDescription: CTXCardFormattedText?
    let fallbackDescription: String?
    let icon: ContextualCardImage?
    let url: URL?
    let backgroundImage: ContextualCardImage?
    var backgroundColor: HexColor?
    let backgroundGradient: ContextualCardGradient?
    let cta: [ContextualCardCTA]?
    
    enum CodingKeys: String, CodingKey {
        case name, icon, url, formattedTitle, formattedDescription, cta
        case fallbackTitle = "title"
        case fallbackDescription = "description"
        case backgroundImage = "bgImage"
        case backgroundColor = "bgColor"
        case backgroundGradient = "bgGradient"
    }

        
}

struct CTXCardFormattedText: Decodable {
    let text: String
    let entities: [CTXCardFormattedTextEntity]
    
    func getFilteredComponents() -> [String] {
        text.components(separatedBy: " ")
    }
    
    func isValid() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: #"\{\}"#, options: [])
            let matchCount = regex.matches(in: text, options: [], range: .init(location: 0, length: text.count))
            return matchCount.count == entities.count
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func getParsedEntities() -> [CTXCardFormattedTextEntity] {
        if !isValid() {
            return entities
        }
        
        var entitiesCopy = entities
        var newEntities = [CTXCardFormattedTextEntity]()
        
        let tokens = getFilteredComponents()
                
        for (index, token) in tokens.enumerated() {
            if token == "{}" && !entitiesCopy.isEmpty {
                var currentEntity = entitiesCopy.removeFirst()
                currentEntity.text += (index == tokens.count - 1 ? "" : " ")
                newEntities.append(currentEntity)
            } else {
                let spacedToken = token + (index == tokens.count - 1 ? "" : " ")
                newEntities.append(CTXCardFormattedTextEntity(text: spacedToken))
            }
        }
        
        // if there is only one enitity for FlexibleView to render, it will ignore the frame width and overflow,
        // To fix the problem, we split the single sentence entity into multiple words entity
        // so that FlexibleView will calculate the view accordingly
        if newEntities.count == 1, let singleEntity = newEntities.first {
            let text = singleEntity.text
            let textList = text.split(separator: " ")
            return textList.map {
                var singleEntityCopy = singleEntity
                singleEntityCopy.text = String($0) + " "
                return singleEntityCopy
            }
        }
        
        
        return newEntities
    }
    
}

struct CTXCardFormattedTextEntity: Decodable, Hashable {
    enum FontStyle: String, Decodable {
        case underline
        case italic
    }
    
    var text: String
    let color: HexColor?
    let url: URL?
    let fontStyle: FontStyle?
    
    var isClickable: Bool {
        if let url = url {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    init(text: String, color: HexColor? = nil, url: URL? = nil, fontStyle: FontStyle? = nil) {
        self.text = text
        self.color = color
        self.url = url
        self.fontStyle = fontStyle
    }
    
    
}



