//
//  CardBackgroundView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI
import Kingfisher


struct CardBackgroundView: View {
    
    enum BackgroundType {
        case image, icon
    }
    
    let cardData: ContextualCard
    var backgroundType: BackgroundType = .image
    
    var body: some View {
        switch backgroundType {
        case .icon:
            getBackground(image: cardData.icon)
        case .image:
            getBackground(image: cardData.backgroundImage)
        }
    }
    
    @ViewBuilder
    func getBackground(image: ContextualCardImage?) -> some View {
        if let image = image {
            if image.imageType == .external {
                KFImage(image.imageUrl)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(contentMode: .fill)
            } else if let asset = cardData.backgroundImage?.assetType, image.imageType == .asset   {
                Image(asset)
            } else {
                Color.clear
            }
        } else if let backgroundGradient = cardData.backgroundGradient,
                 let colors = backgroundGradient.colors?.compactMap({ $0.color }) {
            AngularGradient(gradient: Gradient(colors: colors), center: .center, angle: .degrees(Double(backgroundGradient.angle ?? 0)))
        } else if let backgroundColor = cardData.backgroundColor {
            backgroundColor.color
        } else {
            EmptyView()
        }
    }
}

struct CardBackgroundView_Preview: PreviewProvider {
    static var previews: some View {
        CardBackgroundView(cardData: cardData)
    }
}
