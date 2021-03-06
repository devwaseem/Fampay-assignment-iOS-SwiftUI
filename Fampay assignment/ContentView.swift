//
//  ContentView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 26/06/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var viewModel = ContextualCardViewModel(bigDisplayCardReminderRepo: .init())
    
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
                    RefreshableScrollView(isRefreshing: $viewModel.isRefreshing) {
                        VStack {
                            let width = parentFrame.width - 40
                            ForEach(viewModel.cardGroups ?? []) { cardData in
                                ContextualCardView(cardGroup: cardData, width: width)
                                    .padding(.top, 2)
                                    .environmentObject(viewModel)
                            }
                        }
                        .padding(.bottom, 300)
                    } onRefresh: {
                        viewModel.fetchCardsGroup()
                    }
                    .padding(.horizontal, 20)
                    .background(Color("background-gray"))
                }
                .alert(isPresented: $viewModel.isAlertPresenting) {
                    Alert(title: Text(viewModel.alertTitle))
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)
            .onAppear {
                viewModel.fetchCardsGroup()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
