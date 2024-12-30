//
//  ArticleCardView.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import SwiftUI

struct ArticleCardView: View {
    var iconURL: String?
    var name: String = "Article"
    var description: String = "A SwiftUI view that displays an article."
    
    var body: some View {
        HStack {
            IconView(
                size: CGSize(width: 100 , height: 100),
                applyforegroundColor: (apply: false, color: nil),
                iconURL: iconURL
            )
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                
                Text(description)
                    .font(.body)
                    .lineLimit(3)
            }
        }
    }
}

#Preview {
    ArticleCardView()
}
