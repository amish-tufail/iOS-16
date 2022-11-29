//
//  MenuView.swift
//  iOS16
//
//  Created by Meng To on 2022-11-29.
//

import SwiftUI

struct MenuView: View {
    @Binding var showMenu: Bool
    @AppStorage("menu") var menu: Menu = .compass
    
    var body: some View {
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(true))
    }
}
