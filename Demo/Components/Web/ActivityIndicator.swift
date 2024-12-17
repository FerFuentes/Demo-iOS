//
//  ActivityIndicator.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    var configuration = { (_: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        if isAnimating { uiView.startAnimating() } else { uiView.stopAnimating() }
        configuration(uiView)
    }
}
