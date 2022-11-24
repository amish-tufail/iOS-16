//
//  TappableView.swift
//  iOS16
//
//  Created by Meng To on 2022-11-24.
//

import SwiftUI

struct TappableView: UIViewRepresentable {
    var tapCallback: (UITapGestureRecognizer) -> Void

    typealias UIViewType = UIView

    func makeCoordinator() -> TappableView.Coordinator {
        Coordinator(tapCallback: self.tapCallback)
    }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(sender:)))
       
        /// Set number of touches.
        doubleTapGestureRecognizer.numberOfTouchesRequired = 2
       
        view.addGestureRecognizer(doubleTapGestureRecognizer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) { }

    class Coordinator {
        var tapCallback: (UITapGestureRecognizer) -> Void

        init(tapCallback: @escaping (UITapGestureRecognizer) -> Void) {
            self.tapCallback = tapCallback
        }

        @objc func handleTap(sender: UITapGestureRecognizer) {
            self.tapCallback(sender)
        }
    }
}
