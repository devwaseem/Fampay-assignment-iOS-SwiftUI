//
//  SmallCardWithArrow.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 27/06/21.
//

import SwiftUI

struct SmallCardWithArrowView: View {
    
    let cardGroup: ContextualCardGroup
    let width: CGFloat
    
    var body: some View {
        if cardGroup.isScrollable, let cards = cardGroup.cards {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< cards.count) { idx in
                        SmallCardWithArrowSingleView(data: cards[idx])
                            .frame(width: width * 0.9, height: width * 0.188)
                    }
                }.frame(maxWidth: .infinity)
            }
        } else if let card = cardGroup.cards?.first {
            SmallCardWithArrowSingleView(data: card)
                .frame(height: width * 0.188)
        } else {
            EmptyView()
        }
    }
    
}

fileprivate struct SmallCardWithArrowSingleView: View {
    
    let data: ContextualCard
    
    var body: some View {
        HStack {
            CardBackgroundView(cardData: data, backgroundType: .icon)
                .aspectRatio(1, contentMode: .fit)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            HStack {
                FormattedTextView(formattedTitle: data.formattedTitle, fallbackTitle: data.fallbackTitle, foregroundColor: .black, font: .system(size: 14))
                    .lineLimit(1)
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity)
            Image(systemName: "chevron.forward")
                .padding(.trailing, 20)
        }
        .padding(.leading, 20)
        .frame(height: 60)
        .background(data.backgroundColor?.color ?? .white)
        .cornerRadius(12)
        .onTapGesture {
            let app = UIApplication.shared
            if let url = cardData.url, app.canOpenURL(url) {
                app.open(url, options: [:])
            }
        }
    }
}

struct SmallCardWithArrow_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardWithArrowView(cardGroup: placeholderData[1], width: 350)
            .previewLayout(PreviewLayout.fixed(width: 350, height: 120))
    }
}
