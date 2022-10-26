//
//  HalfSheetView.swift
//  iOS16
//
//  Created by Meng To on 2022-06-07.
//

import SwiftUI

struct HalfSheetView: View {
    @State var showSheet = false

    var body: some View {
        Button("Bottom Sheet") {
            showSheet = true
        }
        .sheet(isPresented: $showSheet) {
            Text("Content")
                .presentationDetents([.height(200), .medium, .large])
                .presentationDragIndicator(.visible)
        }
        .font(.title).bold()
    }
}

struct HalfSheetView_Previews: PreviewProvider {
    static var previews: some View {
        HalfSheetView()
    }
}
