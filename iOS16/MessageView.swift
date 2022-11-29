//
//  MessageView.swift
//  iOS16
//
//  Created by Meng To on 2022-11-29.
//

import SwiftUI

struct MessageView: View {
    @State var time = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var showMessage = true
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "timelapse", variableValue: time)
                .imageScale(.large)
                .font(.system(size: 50).weight(.thin))
                .onReceive(timer) { _ in
                    if time < 1.0 {
                        time += 0.1
                    } else {
                        time = 0.0
                    }
                }
            Text("Switching apps".uppercased())
                .font(.system(size: 40, weight: .bold, width: .condensed))
            Text("Tap and hold any part of the screen for 1 second to show the menu for switching between apps.")
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
            Divider()
            Button {
                withAnimation {
                    showMessage = false
                }
            } label: {
                Text("Got it")
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke())
                    .accentColor(.primary)
            }
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 30)
        .padding(.vertical, 40)
        .background(.ultraThinMaterial)
        .cornerRadius(30)
        .padding(30)
        .opacity(showMessage ? 1 : 0)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
            .background(Image("Wallpaper 1"))
    }
}
