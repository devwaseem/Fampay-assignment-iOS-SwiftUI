//
//  ContextualCardImage.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import Foundation

struct ContextualCardImage: Decodable {
    enum ImageType: String, Decodable {
        case asset, external = "ext"
    }
    
    let imageType: ImageType
    let assetType: String?
    let imageUrl: URL?
}
