//
//  IconView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

struct IconView: View {
    @StateObject private var imageLoader = AsyncImageLoader()
    
    var scale: CGFloat? // For image scaling, if needed
    var size: CGSize = CGSize(width: 25, height: 25) // Default size
    var applyforegroundColor: (apply: Bool, color: Color?)
    var iconName: String = "ic_home" // Default icon asset name
    var iconURL: String?

    var body: some View {
        if let urlString = iconURL,
           let url = URL(string: urlString),
           urlString.hasPrefix("http://") || urlString.hasPrefix("https://") {
            
            // For URL images
            Group {
                switch imageLoader.state {
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                        .frame(width: size.width, height: size.height)
                    
                case .success(let image):
                    imageView(image: image)
                case .failure:
                    iconPlaceholder
                        .onAppear {
                            imageLoader.retryLoadImage()
                        }
                }
            }.frame(width: size.width, height: size.height)
            .onAppear {
                imageLoader.loadImage(from: url, scale: scale ?? 1.0)
            }
        } else {
            // For local asset images
            imageView(image: Image(iconName))
        }
    }
    
    @ViewBuilder
    private func imageView(image: Image) -> some View {
        if applyforegroundColor.apply {
            image
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
                .foregroundColor(applyforegroundColor.color ?? .accentColor)
        } else {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
        }
    }

    private var iconPlaceholder: some View {
        Image("ic_home")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .foregroundColor(.gray)
    }
}

#Preview {
    IconView(
        size: CGSize(width: 70, height: 70),
        applyforegroundColor: (apply: true, color: .gray),
        iconURL: "https://cdn-icons-png.flaticon.com/512/2198/2198321.png"
    )
}
