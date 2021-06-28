//
//  BigDisplayContextualCard.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 27/06/21.
//

import SwiftUI
import Kingfisher

struct BigDisplayContextualCardCarousel: View {
    
    var isScrollable: Bool
    let data: [ContextualCard]
    let width: CGFloat
        
    var body: some View {
        if isScrollable {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<data.count) { idx in
                        BigDisplayContextualCard(data: data[idx])
                            .frame(width: width * 0.9)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        } else if data.count > 0 {
            BigDisplayContextualCard(data: data[0])
        } else {
            Color.clear
        }
    }
}

struct BigDisplayContextualCard: View {
    
    var data: ContextualCard
    
    @State private var isExpanded = false
//    @State private var size: CGSize = .zero
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            GeometryReader { proxy in
                
                BigDisplayContextualCardActionView(data: data)
                    .frame(width: proxy.frame(in: .local).width * 0.4)
                    .background(Color.white)
                    .onTapGesture {
                        isExpanded = false
                    }
                BigDisplayContextualCardContent(data: data)
                    .animation(.spring())
                    .offset(x: isExpanded ? proxy.frame(in: .local).width * 0.4 : 0)
                    .animation(.none)
                    .onTapGesture {
                        let app = UIApplication.shared
                        if let url = data.url, app.canOpenURL(url) {
                            app.open(url, options: [:])
                        }
                    }
                    .onLongPressGesture {
                        isExpanded = true
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(0.914, contentMode: .fit)
        .background(Color.white)
        .cornerRadius(12)
        .clipped()
//        .readSize { size in
//            self.size = size
//        }
    }
    
}

private struct BigDisplayContextualCardActionView: View {
    
    let data: ContextualCard
    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                
            }, label: {
                VStack {
                    Image("bell")
                        .resizable()
                        .frame(width: 22, height: 24)
                    Text("remind later")
                        .font(.system(size: 10))
                        .fixedSize()
                        .foregroundColor(.black)
                }
            })
            .padding()
            .background(Color("card button background"))
            .cornerRadius(12)
            
            Button(action: {
                
            }, label: {
                VStack {
                    Image("clear")
                        .resizable()
                        .frame(width: 22, height: 24)
                    Text("dismiss now")
                        .font(.system(size: 10))
                        .fixedSize()
                        .foregroundColor(.black)
                }
            })
            .padding()
            .background(Color("card button background"))
            .cornerRadius(12)
            .padding(.top, 12)
            
            Spacer()
        }
    }
    
}

private struct BigDisplayContextualCardContent: View {
    
    let data: ContextualCard
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            VStack(alignment: .leading) {
                FormattedTextView(formattedTitle: data.formattedTitle, fallbackTitle: data.fallbackTitle, font: .system(size: 30))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 33)
            
            VStack(alignment: .leading) {
                FormattedTextView(formattedTitle: data.formattedDescription, fallbackTitle: data.fallbackDescription, font: .system(size: 12))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 33)
            .padding(.bottom, 20)
            
            
            if let ctaList = data.cta {
                HStack {
                    ForEach(ctaList.indices) { index in
                        CTAButton(cta: ctaList[index])
                    }
                    Spacer()
                }
                .padding(.horizontal, 33)
                .padding(.bottom, 20)
                .frame(maxWidth: .infinity)
            }
        }
        .background(CardBackgroundView(cardData: data))
        .background(data.backgroundColor?.color ?? .clear)
        .cornerRadius(12)
        
    }
        
    func CTAButton(cta: ContextualCardCTA) -> some View {
        Button(action: {
            if let url = cta.url {
                let app = UIApplication.shared
                if app.canOpenURL(url) {
                    app.open(url, options: [:])
                }
            }
        }, label: {
            Text(cta.text)
                .foregroundColor(cta.textColor?.color)
                .frame(height: 42)
                .padding(.horizontal, 42)
                .padding(.vertical, 4)
                .background(cta.backgroundColor?.color)
                .cornerRadius(6)
        })
    }
}


struct BigDisplayContextualCard_Previews: PreviewProvider {
    static var previews: some View {
        BigDisplayContextualCard(data: cardData)
            .frame(width: 400)
            .previewLayout(PreviewLayout.fixed(width: 500, height: 500))
    }
}


