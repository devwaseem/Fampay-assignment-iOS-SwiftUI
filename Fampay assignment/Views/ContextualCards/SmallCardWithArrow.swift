//
//  SmallCardWithArrow.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 27/06/21.
//

import SwiftUI

struct SmallCardWithArrowView: View {
    
    let isScrollable: Bool
    let cardData: [ContextualCard]
    let width: CGFloat
    
    
    var body: some View {
        if isScrollable {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<cardData.count) { idx in
                        SmallCardWithArrowSingleView(data: cardData[idx])
                            .frame(width: width * 0.9)
                    }
                }.frame(maxWidth: .infinity)
            }
        } else if cardData.count > 0 {
            SmallCardWithArrowSingleView(data: cardData[0])
        } else {
            Color.clear
        }
    }
    
}

fileprivate struct SmallCardWithArrowSingleView: View {
    
    let data: ContextualCard
        
    var body: some View {
        HStack {
            CardBackgroundView(cardData: data)
                .aspectRatio(1, contentMode: .fit)
                .background(Color.red)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            HStack {
                Text("Small card with arrow")
                    .multilineTextAlignment(.leading)
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
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct SmallCardWithArrow_Previews: PreviewProvider {
    static var previews: some View {
        SmallCardWithArrowView(isScrollable: true, cardData: [cardData, cardData], width: 350)
            .previewLayout(PreviewLayout.fixed(width: 350, height: 60))
    }
}
