//
//  ContextualCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI

struct ContextualCardView: View {
    
    let cardGroup: ContextualCardGroup
    let width: CGFloat
    
    var body: some View {
        switch cardGroup.designType {
        case ContextualCardDesignTypes.bigDisplayCard:
            BigDisplayContextualCard(cardGroup: cardGroup, width: width)
        case ContextualCardDesignTypes.smallCardWithArrow:
            SmallCardWithArrowView(cardGroup: cardGroup, width: width)
        case ContextualCardDesignTypes.smallDisplayCard:
            SmallDisplayCard(cardGroup: cardGroup, width: width)
        case ContextualCardDesignTypes.imageCard:
            ContextualImageCard(cardGroup: cardGroup, width: width)
        case ContextualCardDesignTypes.dynamicWidthCard:
            DynamicWidthContextualCard(cardGroup: cardGroup, width: width)
        default:
            EmptyView()
        }
    }
}
