//
//  DynamicWidthContextualCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 29/06/21.
//

import SwiftUI
import Kingfisher

struct ContextualImageCard: View {
    
    let cardGroup: ContextualCardGroup
    let width: CGFloat
    
    var body: some View {
        if let cards = cardGroup.cards {
            ScrollView(.horizontal) {
                ForEach(0 ..< cards.count) { index in
                    ContextualImageSingleCard(image: cards[index].backgroundImage,
                                                     actionUrl: cards[index].url)
                        .frame(width: width * 0.95)
                        .frame(minHeight: 10)
                }
            }
        } else if let card = cardGroup.cards?.first {
            ContextualImageSingleCard(image: card.backgroundImage,
                                             actionUrl: card.url)
                .frame(width: width)
                .frame(minHeight: 10)
        } else {
            EmptyView()
        }
    }
}

fileprivate struct ContextualImageSingleCard: View {
    
    let image: ContextualCardImage?
    let actionUrl: URL?
    
    var body: some View {
        if let imageUrl = image?.imageUrl, image?.imageType == .external {
            KFImage(imageUrl)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    let app = UIApplication.shared
                    if let url = actionUrl, app.canOpenURL(url) {
                        app.open(url, options: [:])
                    }
                }
        } else {
            EmptyView()
        }
    }
}

struct DynamicWidthContextualCard_Preview: PreviewProvider {
    static var previews: some View {
        ContextualImageCard(cardGroup: placeholderData[0], width: 300)
            .previewLayout(.fixed(width: 300, height: 500))
    }
}

