//
//  CustomLayoutView.swift
//  iOS16
//
//  Created by Meng To on 2022-12-10.
//

import SwiftUI

struct CustomLayoutView: View {
    @State var isRadial = false
    var icons = ["calendar", "message", "figure.walk", "music.note"]
    
    var body: some View {
        let layout = isRadial ? AnyLayout(RadialLayout()) : AnyLayout(CustomLayout())
        
        ZStack {
            Circle().stroke()
            
            layout {
                ForEach(icons, id: \.self) { item in
                    Circle()
                        .fill(.black)
                        .frame(width: 44)
                        .overlay(Image(systemName: item).foregroundColor(.white))
                }
            }
            .frame(width: 200)
            .overlay(Circle().stroke())
        }
        .onTapGesture {
            withAnimation(.spring()) {
                isRadial.toggle()
            }
        }
    }
}

struct CustomLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLayoutView()
    }
}

struct CustomLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        for (index, subview) in subviews.enumerated() {
            
            // Position
            var point = CGPoint(x: 50 * index, y: 0 * index)
                .applying(CGAffineTransform(rotationAngle: 5))
            
            // Center
            point.x += bounds.midX
            point.y += bounds.midY
            
            // Place view
            subview.place(at: point, anchor: .center, proposal: .unspecified)
        }
    }
}
