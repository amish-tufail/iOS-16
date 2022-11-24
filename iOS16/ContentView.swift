//
//  ContentView.swift
//  iOS16
//
//  Created by Meng To on 2022-06-06.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("menu") var menu: Menu = .compass
    @State var showMenu = false
    
    var body: some View {
        ZStack {
            switch menu {
            case .compass:
                CompassView()
            case .card:
                CardReflectionView()
            case .charts:
                ChartView()
            case .radial:
                RadialLayoutView()
            case .halfsheet:
                HalfSheetView()
            case .gooey:
                GooeyView()
            case .actionbutton:
                MetaballView()
            }
            
            GeometryReader { proxy in
                Color.black.opacity(0.0001)
                    .frame(height: proxy.safeAreaInsets.top)
                    .ignoresSafeArea()
                    .onTapGesture(count: 2) {
                        showMenu = true
                    }
            }
        }
        .sheet(isPresented: $showMenu) {
            List(navigationItems) { item in
                Button {
                    menu = item.menu
                    showMenu = false
                } label: {
                    Label("\(item.title)", systemImage: item.icon)
                }
                .padding(8)
                .foregroundColor(.primary)
            }
            .listStyle(.plain)
            .presentationDetents([.medium, .large])
            .padding(.top, 20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
