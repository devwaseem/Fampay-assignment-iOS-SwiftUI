//
//  DynamicWidthContextualCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 29/06/21.
//

import SwiftUI
import Kingfisher

struct DynamicWidthContextualCard: View {
    let cardGroup: ContextualCardGroup
    let width: CGFloat
    
    var body: some View {
        if let cards = cardGroup.cards {
            HStack {
                ForEach(0 ..< cards.count) { index in
                    DynamicWidthContextualSingleCard(data: cards[index])
                        .frame(height: CGFloat(cardGroup.height ?? 0))
                }
                Spacer()
            }
        } else if let card = cardGroup.cards?.first {
            DynamicWidthContextualSingleCard(data: card)
                .frame(height: CGFloat(cardGroup.height ?? 0))
        } else {
            EmptyView()
        }
    }
}


fileprivate struct DynamicWidthContextualSingleCard: View {
    let data: ContextualCard
    
    var body: some View {
        if let image = data.backgroundImage {
            if data.backgroundImage?.imageType == .external {
                KFImage(image.imageUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture {
                        handleUrl(url: data.url)
                    }
            } else if let asset = image.assetType, image.imageType == .asset   {
                Image(asset)
                    .onTapGesture {
                        handleUrl(url: data.url)
                    }
            } else {
                EmptyView()
            }
        } else if let backgroundGradient = data.backgroundGradient,
                  let colors = backgroundGradient.colors?.compactMap({ $0.color }) {
             AngularGradient(gradient: Gradient(colors: colors), center: .center, angle: .degrees(Double(backgroundGradient.angle ?? 0)))
                .onTapGesture {
                    handleUrl(url: data.url)
                }
        } else if let backgroundColor = data.backgroundColor {
             backgroundColor.color
                .onTapGesture {
                    handleUrl(url: data.url)
                }
        } else {
          EmptyView()
        }
        
    }
    
    func handleUrl(url: URL?) {
        let app = UIApplication.shared
        if let url = data.url, app.canOpenURL(url) {
            app.open(url, options: [:])
        }
    }
}



struct DynamicWidthContextualCard_Previews: PreviewProvider {
    static var previews: some View {
        DynamicWidthContextualCard(cardGroup: placeholderData[2], width: 300)
            .previewLayout(.fixed(width: 500, height: 600))
    }
}
