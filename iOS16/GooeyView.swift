//
//  GooeyView.swift
//  iOS16
//
//  Created by Meng To on 2022-10-19.
//

import SwiftUI

struct GooeyView: View {
    @State var translation: CGSize = .zero
    @State var show = false
    @State var selection = 1
    @State var tap = false
    
    var body: some View {
        Rectangle()
            .overlay(
                Rectangle()
                    .fill(show ? .blue : .black)
                    .frame(height: show ? 500 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            )
            .overlay(
                Text("drink more water")
                    .font(.system(size: 70, weight: .bold))
                    .foregroundColor(.white)
                    .frame(height: show ? 500 : 0)
                    .padding(30)
                    .offset(y: 90)
            )
            .mask(canvas)
            .overlay(
                VStack(spacing: 20) {
                    Circle().stroke(lineWidth: 2).frame(width: 40)
                        .overlay(Circle().stroke(lineWidth: 1).frame(width: 20))
                    Group {
                        if selection == 1 {
                            Text("Gooey Effect").font(.largeTitle).bold()
                            Text("It’s fairly easy to achieve using the Canvas in SwiftUI.")
                        }
                        if selection == 2 {
                            Text("Canvas").font(.largeTitle).bold()
                            Text("Since the gooey animation happens between multiple elements, we need to draw multiple symbols inside a Canvas.")
                        }
                        if selection == 3 {
                            Text("Drag Gesture").font(.largeTitle).bold()
                            Text("Let’s make the circle draggable to see how each element responds as they come in contact with each other!")
                        }
                    }
                    .transition(.identity)
                }
                    .overlay(
                        Image(systemName: "xmark").bold()
                            .offset(y: 522)
                            .onTapGesture {
                                withAnimation(.bounce) {
                                    show.toggle()
                                }
                            }
                    )
                    .frame(width: 300, height: 200)
                    .foregroundStyle(.white)
                    .offset(y: -220)
                    .onTapGesture {
                        withAnimation(.bounce) {
                            show.toggle()
                        }
                    }
            )
            .gesture(drag)
            .overlay(
                ZStack {
                    Circle().fill(.red).frame(width: 36).offset(x: -158, y: -48)
                        .opacity(selection == 1 ? 1 : 0.01)
                        .onTapGesture { withAnimation(.bounce) { selection = 1
                            tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.bounce) {
                                    tap = false
                                }
                            } }}
                    Circle().fill(.blue).frame(width: 36).offset(x: -58, y: -48)
                        .opacity(selection == 2 ? 1 : 0.01)
                        .onTapGesture { withAnimation(.bounce) { selection = 2
                            tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.bounce) {
                                    tap = false
                                }
                            } }}
                    Circle().fill(.green).frame(width: 36).offset(x: 42, y: -48)
                        .opacity(selection == 3 ? 1 : 0.01)
                        .onTapGesture { withAnimation(.bounce) { selection = 3
                            tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.bounce) {
                                    tap = false
                                }
                            } }}
                }
                    .scaleEffect(show ? 0 : 1)
            )
            .ignoresSafeArea()
    }
    
    var canvas: some View {
        Canvas { context, size in
            context.addFilter(.alphaThreshold(min: 0.95))
            context.addFilter(.blur(radius: 5))
            context.drawLayer { context in
                for index in 1...6 {
                    if let symbol = context.resolveSymbol(id: index) {
                        context.draw(symbol, at: .zero, anchor: .topLeading)
                    }
                }
            }
        } symbols: {
            RoundedRectangle(cornerRadius: 54)
                .frame(height: show ? 700 : 300)
                .padding(show ? 0 : 8)
                .offset(y: show ? 0 : 44)
                .scaleEffect(tap ? 1.05 : 1)
                .tag(1)
            Circle()
                .frame(width: 60)
                .padding(8)
                .offset(y: selection == 1 ? 340 : 350)
                .offset(x: translation.width, y: translation.height)
                .tag(2)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 125, height: 37)
                .offset(x: 135, y: 11)
                .tag(3)
            Circle()
                .frame(width: 60)
                .padding(8)
                .offset(x: 100, y: selection == 2 ? 340 : 350)
                .tag(4)
            Circle()
                .frame(width: 60)
                .padding(8)
                .offset(x: 200, y: selection == 3 ? 340 : 350)
                .tag(5)
            Circle()
                .frame(width: 60)
                .padding(8)
                .offset(x: 158, y: show ? 690 : 500)
                .opacity(show ? 1 : 0)
                .tag(6)
        }
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
            }
            .onEnded { value in
                withAnimation(.bounce) {
                    translation = .zero
                }
            }
    }
}

struct GoeyView_Previews: PreviewProvider {
    static var previews: some View {
        GooeyView()
    }
}

extension Animation {
    static let bounce = Animation.spring(response: 0.5, dampingFraction: 0.6)
}
