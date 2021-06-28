//
//  CardBackgroundView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI
import Kingfisher


struct CardBackgroundView: View {
    
    let cardData: ContextualCard
    
    var body: some View {
        if let backgroundImage = cardData.backgroundImage {
            if backgroundImage.imageType == .external {
                KFImage(cardData.backgroundImage?.imageUrl)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fill)
            } else if let asset = cardData.backgroundImage?.assetType, backgroundImage.imageType == .asset   {
                Image(asset)
            }
        }else {
            backgroundColor?.color ?? .clear
        }
    }
}

struct CardBackgroundView_Preview: PreviewProvider {
    static var previews: some View {
        CardBackgroundView(cardData: cardData)
    }
}
