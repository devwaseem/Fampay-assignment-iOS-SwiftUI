//
//  SmallDisplayCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI


struct SmallDisplayCard: View {
    
    let cardGroup: ContextualCardGroup
    let width: CGFloat
    
    var body: some View {
        if let cards = cardGroup.cards {
            if cardGroup.isScrollable {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<cards.count) { index in
                            SmallDisplayCardSingleView(cardData: cards[index])
                                .frame(width: width * 0.9, height: width * 0.188)
                        }
                    }.frame(maxWidth: .infinity)
                }
            } else {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(0..<cards.count) { index in
                        SmallDisplayCardSingleView(cardData: cards[index])
                            .frame(height: width * 0.188)
                    }
                }
            }
        } else if let cardData = cardGroup.cards?.first {
            SmallDisplayCardSingleView(cardData: cardData)
                .frame(height: width * 0.188)
            
        } else {
            EmptyView()
        }
    }
}

fileprivate struct SmallDisplayCardSingleView: View {
    
    let cardData: ContextualCard
    
    var body: some View {
        HStack {
            CardBackgroundView(cardData: cardData, backgroundType: .icon)
                .aspectRatio(1, contentMode: .fit)
            VStack(spacing: 4) {
                Spacer()
                FormattedTextView(formattedTitle: cardData.formattedTitle, fallbackTitle: cardData.fallbackTitle, foregroundColor: .black, font: .system(size: 14))
                    .lineLimit(1)
                if let formattedDescription = cardData.formattedDescription, formattedDescription.isValid() {
                    FormattedTextView(formattedTitle: cardData.formattedDescription, fallbackTitle: cardData.fallbackDescription, foregroundColor: Color("small card description"), font: .system(size: 14))
                        .lineLimit(1)
                        .padding(.top, -4)
                }
                Spacer()
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
        }
        .frame(minHeight: 10)
        .padding(.leading, 20)
        .padding(.vertical, 20)
        .background(cardData.backgroundColor?.color)
        .cornerRadius(12)
        .onTapGesture {
            let app = UIApplication.shared
            if let url = cardData.url, app.canOpenURL(url) {
                app.open(url, options: [:])
            }
        }
    }
}

struct SmallDisplayCard_Preview: PreviewProvider {
    static var previews: some View {
        SmallDisplayCard(cardGroup: placeholderData[5], width: 500)
            .previewLayout(.fixed(width: 500, height: 500))
    }
}
