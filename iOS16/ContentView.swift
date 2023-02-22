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
    @GestureState var press = false
    
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
                ActionButtonView()
            }
        }
        .overlay(
            MessageView()
        )
        .gesture(longPress)
        .onTapGesture {}
        .sheet(isPresented: $showMenu) {
            MenuView()
        }
    }
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1)
            .updating($press) { currentState, gestureState, transaction in
                gestureState = currentState
            }
            .onEnded { value in
                showMenu = true
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
