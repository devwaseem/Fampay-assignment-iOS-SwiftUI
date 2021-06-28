//
//  HexColor.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation
import SwiftUI
import UIKit.UIColor

enum HexColorError: Error {
    case invalidHex
}

/** Simple struct that converts Color Hex represented as String  to `UIColor` (UIKit) and `Color` (SwiftUI)
  - Throws: `HexColorError.invalidHex`
            if hexString is invalid
 */
struct HexColor: Hashable {
    var rawValue: String
    var uiColor: UIColor
    
    var color: Color {
        Color(uiColor)
    }
        
    init(rawValue: String) throws {
        self.rawValue = rawValue
        var hexString = rawValue.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard
            hexString.starts(with: "#"),
            hexString.dropFirst().count == 6 || hexString.dropFirst().count == 3 || hexString.dropFirst().count == 8
        else {
            throw HexColorError.invalidHex
        }
        
        hexString.removeFirst()
        
        if hexString.count == 3 {
            hexString = hexString.map { "\($0)\($0)" } .joined()
        }
        
        let hasAlpha = hexString.count == 8
        if !hasAlpha {
            hexString += "ff"
        }
        
        var hexCode: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexCode)
        
        let red = CGFloat((hexCode & 0xff000000) >> 24) / 255.0
        let green = CGFloat((hexCode & 0xff0000) >> 16) / 255.0
        let blue = CGFloat((hexCode & 0xff00) >> 8) / 255.0
        let alpha = CGFloat(hexCode & 0xff) / 255.0
        
        self.uiColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
            
}

extension HexColor: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hexString = try container.decode(String.self)
        try self.init(rawValue: hexString)
    }
    
}


