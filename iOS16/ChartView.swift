//
//  ChartView.swift
//  iOS16
//
//  Created by Meng To on 2022-06-07.
//

import SwiftUI
import Charts

struct ChartView: View {
    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Category", item.category),
                y: .value("Value", item.value)
            )
            .cornerRadius(10)
            .foregroundStyle(.linearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
        }
        .frame(width: 300, height: 300)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

struct Value: Identifiable {
    var id = UUID()
    var category: String
    var value: Double
}

let data = [
    Value(category: "A", value: 5),
    Value(category: "B", value: 9),
    Value(category: "C", value: 7),
]
