//
//  CompassView.swift
//  iOS16
//
//  Created by Meng To on 2022-10-11.
//

import SwiftUI

struct CompassView: View {
    @ObservedObject var manager = MotionManager()
    @ObservedObject var compassHeading = CompassHeading()
    @State var show = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.radialGradient(colors: [Color(#colorLiteral(red: 0.2970857024, green: 0.3072845936, blue: 0.4444797039, alpha: 1)), .black], center: .center, startRadius: 1, endRadius: 400))
                .ignoresSafeArea()
            
            circles
                .overlay(waypoints)
                .rotationEffect(Angle(degrees: compassHeading.degrees))
            
            CircleLabelView(radius: 135, text: "Latitude 35.08587 E • Longitude 21.43673 W • Elevation 64M • Incline 12 •".uppercased(), kerning: 3, size: CGSize(width: 225, height: 225))
                .foregroundStyle(.white)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .bold()
            
            strokes
                .rotationEffect(Angle(degrees: compassHeading.degrees))
            
            Circle()
                .trim(from: 0.6, to: 0.9)
                .stroke(.radialGradient(colors: [.white.opacity(0.2), .white.opacity(0)], center: .center, startRadius: 0, endRadius: 200), style: StrokeStyle(lineWidth: 200))
                .frame(width: 200, height: 200)
            
            VStack {
                Text("\(String(format: "%.0f", abs(compassHeading.degrees)))º \(Direction(compassHeading.degrees))".uppercased())
                    .font(.largeTitle)
                Text("San Francisco".uppercased())
                    .font(.footnote)
                    .fontWeight(.medium)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            buttons
        }
    }
    
    var buttons: some View {
        HStack(spacing: 30) {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 64, height: 44)
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.3408924341, green: 0.3429200053, blue: 0.3997989893, alpha: 1)), Color(#colorLiteral(red: 0.02498620935, green: 0.04610963911, blue: 0.08353561908, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                    .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                )
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 1))
                .overlay(Image(systemName: "list.bullet").foregroundStyle(.white))
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 52, height: 52)
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.3408924341, green: 0.3429200053, blue: 0.3997989893, alpha: 1)), Color(#colorLiteral(red: 0.02498620935, green: 0.04610963911, blue: 0.08353561908, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                    .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                )
                .overlay(
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(
                            .linearGradient(colors: [Color(#colorLiteral(red: 1, green: 0.7176470588, blue: 0.6980392157, alpha: 1)), Color(#colorLiteral(red: 0.7764705882, green: 0.3411764706, blue: 0.3098039216, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                            .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                        )
                )
                .overlay(
                    Circle()
                        .stroke(.white, style: StrokeStyle(lineWidth: 1, dash: [1, 1]))
                        .frame(width: 22, height: 22)
                )
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 1))
                .overlay(Image(systemName: "plus").foregroundStyle(.white))
            
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 64, height: 44)
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.3408924341, green: 0.3429200053, blue: 0.3997989893, alpha: 1)), Color(#colorLiteral(red: 0.02498620935, green: 0.04610963911, blue: 0.08353561908, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.2), radius: 0, x: 1, y: 1))
                    .shadow(.inner(color: .white.opacity(0.05), radius: 4, x: 0, y: -4))
                    .shadow(.drop(color: .black.opacity(0.5), radius: 30, y: 30))
                )
                .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 1))
                .overlay(Image(systemName: "location.north.circle.fill").foregroundStyle(.white))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .offset(y: -100)
    }
    
    var strokes: some View {
        ZStack {
            Circle()
                .strokeBorder(gradient, style: StrokeStyle(lineWidth: 5, dash: [1, 1]))
            Circle()
                .strokeBorder(gradient, style: StrokeStyle(lineWidth: 10, dash: [1, 6]))
            Circle()
                .strokeBorder(gradient, style: StrokeStyle(lineWidth: 15, dash: [1, 62]))
            
        }
        .frame(width: 315, height: 315)
    }
    
    var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(#colorLiteral(red: 0.61807781457901, green: 0.6255635619163513, blue: 0.7079070806503296, alpha: 1)), location: 0),
                .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), location: 1)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    var circles: some View {
        ZStack {
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [.black.opacity(0.5), .black.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 0.5, y: 0.5))
                )
                .scaleEffect(1.2)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [.black.opacity(0.5), .black.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 0.5, y: 0.5))
                )
                .scaleEffect(1.5)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.03137254902, green: 0.0431372549, blue: 0.06666666667, alpha: 1)), Color(#colorLiteral(red: 0.2705882353, green: 0.2705882353, blue: 0.3254901961, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                    .shadow(.drop(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
                )
                .padding(20)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [Color(#colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1529411765, alpha: 1)), Color(#colorLiteral(red: 0.06666666667, green: 0.07058823529, blue: 0.137254902, alpha: 1))], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.drop(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                    .shadow(.inner(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
                )
                .padding(80)
                
            Circle()
                .foregroundStyle(
                    .radialGradient(colors: [Color(#colorLiteral(red: 0.03921568627, green: 0.0431372549, blue: 0.1215686275, alpha: 1)), Color(#colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.3215686275, alpha: 1))], center: .center, startRadius: 0, endRadius: 100)
                    .shadow(.inner(color: .white.opacity(0.25), radius: 0, x: 1, y: 1))
                    .shadow(.drop(color: .black.opacity(0.25), radius: 0, x: 1, y: 1))
                )
                .padding(100)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [.black.opacity(0.5), .black.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 1, y: 1))
                )
                .padding(120)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [.black.opacity(0.5), .black.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 1, y: 1))
                )
                .padding(145)
            
            Circle()
                .foregroundStyle(
                    .linearGradient(colors: [.black.opacity(0.5), .black.opacity(0.0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .shadow(.inner(color: .white.opacity(0.5), radius: 0, x: 1, y: 1))
                )
                .padding(170)
            
            Circle()
                .foregroundStyle(.white)
                .padding(188)
        }
    }
    
    var waypoints: some View {
        ZStack {
            Circle()
                .fill(.blue)
                .frame(width: 16, height: 16)
                .offset(x: 100, y: 210)
            
            Circle()
                .fill(.red)
                .frame(width: 16, height: 16)
                .offset(x: -120, y: -200)
            
            Circle()
                .fill(.green)
                .frame(width: 16, height: 16)
                .offset(x: 100, y: -150)
        }
    }
}

struct CompassView_Previews: PreviewProvider {
    static var previews: some View {
        CompassView()
    }
}
