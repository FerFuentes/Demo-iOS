//
//  ArticleDetailView.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import SwiftUI

struct ArticleDetailView: View {
    @EnvironmentObject var viewModel: ArticlesViewModel
    var articleId: String
    
    var body: some View {
        
        List {
            Section {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(viewModel.articleDetails?.imagesURL ?? [], id: \.self) { imageURL in
                            IconView(
                                size: CGSize(width: 300, height: 200),
                                applyforegroundColor: (apply: false, color: nil),
                                iconURL: imageURL
                            )
                        }
                    }.listRowSeparator(.hidden).listRowInsets(EdgeInsets())
                }.listRowSeparator(.hidden).listRowInsets(EdgeInsets())
            } footer: {
                Text("\(viewModel.articleDetails?.description ?? "")")
                    .listRowSeparator(.hidden)
            }
        }.listStyle(.plain)
            .task {
                await viewModel.fetchArticleDetails(id: articleId)
            }
    }
}

#Preview {
    ArticleDetailView(articleId: "")
}
