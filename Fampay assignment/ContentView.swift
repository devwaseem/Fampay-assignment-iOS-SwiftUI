//
//  ContentView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var isRefreshing = false
    
    var body: some View {
        GeometryReader { parentProxy in
            let parentFrame = parentProxy.frame(in: .global)
            VStack {
                HStack {
                    Spacer()
                    Image("fampaylogo")
                    Spacer()
                }
                .offset(y: -10)
                .frame(height: 40)
                VStack {
                    RefreshableScrollView(isRefreshing: $isRefreshing) {
                        VStack {
                            SmallCardWithArrowView(isScrollable: true, cardData: [cardData, cardData], width: parentFrame.width - 40)
                            BigDisplayContextualCardCarousel(isScrollable: false, data: [cardData, cardData, cardData], width: parentFrame.width - 40)
                            .padding(.top, 20)
                        }
                    } onRefresh: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isRefreshing = false
                        }
                    }
                    .padding(.horizontal, 20)
                    .background(Color("background-gray"))
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
