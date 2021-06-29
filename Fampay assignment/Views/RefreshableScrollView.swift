//
//  RefreshableScrollView.swift
//  Fampay assignment
//
//  Created by Waseem Akram on 27/06/21.
//

import SwiftUI

fileprivate let refreshableScrollViewFrameLayer = "RefreshableScrollViewFrameLayer"

struct RefreshableScrollView<Content: View>: View {
    
    var axes: Axis.Set
    var showsIndicators: Bool
    var content: () -> Content
    @Binding private var isRefreshing: Bool
    
    @State private var previousOffset: CGFloat = 0
    @State private var canRefresh = true
    private var offsetForRefreshTrigger: CGFloat = 50
    private var onRefreshAction: () -> Void
    
    init(_ axes: Axis.Set = .vertical,
         showsIndicators: Bool = true,
         isRefreshing: Binding<Bool>,
         @ViewBuilder content: @escaping () -> Content,
         onRefresh: @escaping () -> Void
    ) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self.content = content
        self._isRefreshing = isRefreshing
        self.onRefreshAction = onRefresh
    }
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .animation(.easeInOut)
                    .offset(y: isRefreshing ? 24 : -200)
                    .zIndex(-1)
                Spacer()
            }.clipped()
                        
            ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: showsIndicators) {
                offsetReader
                content()
                    .animation(.easeInOut)
                    .offset(y: isRefreshing ? 72 : 0)
                
            }
            .onPreferenceChange(OffsetPreferenceKey.self, perform: { value in
                if canRefresh
                    && value > previousOffset // can refresh only if the scrolling direction is down
                    && value > offsetForRefreshTrigger // trigger refresh once it crosses the offset
                    && !isRefreshing {
                    
//                    isRefreshing = true
                    onRefreshAction()
                    canRefresh = false
                }
                
                previousOffset = value
                
                // can refresh only if the scrollview offset is close to top. i.e cannot refresh again while being scrolled
                if(previousOffset < 4) {
                    canRefresh = true
                }
            })

            .coordinateSpace(name: refreshableScrollViewFrameLayer)
        }
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.red
                .preference(key: OffsetPreferenceKey.self,
                            value: proxy.frame(in: .named(refreshableScrollViewFrameLayer)).minY)
            
        }
        .frame(height: 0)
    }
    
}

fileprivate struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

fileprivate struct RefreshableScrollView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableScrollView(isRefreshing: .constant(true)) {
            Text("Hello")
            Text("Hello")
        } onRefresh: {
            
        }
    }
}


