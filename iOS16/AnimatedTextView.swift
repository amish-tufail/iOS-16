//
//  AnimatedTextView.swift
//  iOS16
//
//  Created by Meng To on 2022-10-18.
//

import SwiftUI

struct AnimatedTextView: View {
    @State var show = false
    @State var offsetY = 0.0
    
    var body: some View {
        ScrollView {
            Text("Large Title")
                .font(.system(size: offsetY < 59 ? 30 : 17)).bold()
                .padding(.horizontal, 20)
                .overlay(
                    geometry
                )
            
            Text("Text Animation")
                .font(.system(size: show ? 100 : 17)).fontWeight(.bold)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
                .padding(20)
        }
        .onPreferenceChange(TextPreferenceKey.self) { value in
            offsetY = value
        }
    }
    
    var geometry: some View {
        GeometryReader { proxy in
            Color.clear.preference(key: TextPreferenceKey.self, value: proxy.frame(in: .global).minY)
        }
    }
}

struct AnimatedTextView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedTextView()
    }
}

struct TextPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
