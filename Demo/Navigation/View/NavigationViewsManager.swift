//
//  NavigationView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

class NavigationViewsManager {
    static var shared: NavigationViewsManager {
        return _shared
    }
    
    private static let _shared = NavigationViewsManager()
    
    @MainActor @ViewBuilder
    func destination(_ item: NavigationModel) -> some View {
        
        
        switch item.action {
        case .openURL(let url, let showTitle):
            if showTitle {
                NavigationView {
                    AppPageWebView(title: item.key.rawValue, url: URL(string: url))
                }
                
            } else {
                AppPageWebView(title: item.key.rawValue, url: URL(string: url))
                    .ignoresSafeArea()
            }
        case .openView:
            switch item.key {
            case .home:
                NavigationView {
                    HomeView()
                        .navigationTitle(item.key.rawValue)
                }
            case .users:
                NavigationView {
                    UsersView()
                        .navigationTitle(item.key.rawValue)
                }
            case .messages:
                NavigationView {
                    MessagesView()
                        .navigationTitle(item.key.rawValue)
                }
            case .about:
                NavigationView {
                    AboutView()
                        .navigationTitle(item.key.rawValue)
                }
            case .settings:
                SettingsView()
                    .navigationTitle(item.key.rawValue)
            }
        }
    }
}
