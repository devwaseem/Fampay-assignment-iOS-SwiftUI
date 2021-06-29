//
//  FormattedTextView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 28/06/21.
//

import SwiftUI

struct FormattedTextView: View {
    var formattedTitle: CTXCardFormattedText?
    var fallbackTitle: String?
    var foregroundColor: Color = .white
    var font: Font? = nil
    
    @ViewBuilder
    var body: some View {
        if let formattedTitle = formattedTitle, formattedTitle.isValid() {
            FlexibleHGrid(data: formattedTitle.getParsedEntities(), spacing: 0, alignment: HorizontalAlignment.leading) { entity in
                _FormattedTextView(entity: entity, font: font, foregroundColor: foregroundColor)
                
            }
        } else if let fallbackTitle = fallbackTitle {
            HStack {
                Text(fallbackTitle)
                    .foregroundColor(foregroundColor)
                    .font(font)
                    .background(Color.red)
                Spacer()
            }
        } else {
            Color.clear
        }
    }
    
    
}

fileprivate struct _FormattedTextView: View {
    let entity: CTXCardFormattedTextEntity
    let font: Font?
    var foregroundColor: Color = .white
    var body: some View {
        if entity.isClickable {
            Button(action: {
                if let url = entity.url {
                    UIApplication.shared.open(url, options: [:])
                }
            }, label: {
                FormattedText
            })
        } else {
            FormattedText
        }
    }
    
    var FormattedText: some View {
        Text(entity.text)
            .foregroundColor(entity.color?.color ?? foregroundColor)
            .font(font)
            .if(entity.fontStyle == .italic) { Text in
                Text.italic()
            } else: { Text in
                Text.if(entity.fontStyle == .underline) { Text in
                    Text.underline()
                }
            }
    }
}
