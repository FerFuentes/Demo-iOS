//
//  HomesView.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject var viewModel = ArticlesViewModel()
    private let navigationManager = NavigationViewsManager.shared
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.articles, id: \.id) { article in
                    
                    NavigationLink {
                        navigationManager.destination(NavigationModel(id: "6" , key: .detailArticles(id: article.id), action: .openView))
                            .environmentObject(viewModel)
                            .navigationTitle(article.name)
                    } label: {
                        ArticleCardView(iconURL: article.imageURL, name: article.name, description: article.description)
                    }
                    
                }
            } header: {
                Text("New Articles")
                    .font(.headline)
            }
            
            
        }.alert(isPresented: $viewModel.showAlertError.show, content: {
            
            switch viewModel.showAlertError.requestError {
                
            case .internetConnection(let message):
                Alert(title: Text("Error"), message: Text(message), primaryButton: .default(Text("Try again"), action: {
                    Task {
                        await viewModel.validateLocationPermission()
                    }
                }), secondaryButton: .default(Text("OK"))
                )
            default:
                Alert(
                    title: Text("Error"),
                    message: Text("\(viewModel.showAlertError.requestError?.customMessage ?? "Unknown error")"),
                    dismissButton: .default(Text("OK"))
                )
            }
           
            
        }).redacted(reason: viewModel.loading ? .placeholder : .init())
            .refreshable {
            Task {
                await viewModel.validateLocationPermission()
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.validateLocationPermission()
                    }
                } label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .renderingMode(.template)
                        .resizable()
                }
            }
        }.task {
            await viewModel.validateLocationPermission()
        }
    }
}

#Preview {
    ArticlesView()
}
