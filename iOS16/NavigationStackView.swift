//
//  NavigationStackView.swift
//  iOS16
//
//  Created by Meng To on 2022-06-07.
//

import SwiftUI

struct NavigationStackView: View {
    var body: some View {
        NavigationStack {
            List(items) { item in
                NavigationLink(value: item) {
                    Text(item.title)
                }
            }
            .navigationTitle("Navigation Stack")
            .navigationDestination(for: FoodItem.self) { item in
                ChartView()
            }
        }
    }
}

struct NavigationStackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackView()
    }
}

struct FoodItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
}

var items = [
    FoodItem(title: "Title 1"),
    FoodItem(title: "Title 2"),
    FoodItem(title: "Title 3"),
    FoodItem(title: "Title 4")
]
