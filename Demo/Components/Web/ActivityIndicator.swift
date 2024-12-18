//
//  ActivityIndicator.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    @Binding var isAnimating: Bool
    var color: UIColor?
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicator = UIView()
        if let color = color {
            activityIndicator.color = color
        }
        activityIndicator.style = style
        
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimating { uiView.startAnimating() } else { uiView.stopAnimating() }
    }

}

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
