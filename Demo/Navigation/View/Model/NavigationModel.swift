//
//  Untitled.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

struct NavigationModel: Decodable, Identifiable {
    let id: String
    var key: NavigationKey
    var iconURL: String?
    var action: NavigationAction
}

enum NavigationAction: Decodable, Equatable {
    case openURL(url: String, showTitle: Bool)
    case openView
}

enum NavigationKey: Decodable {
    case home
    case users
    case about
    case messages
    case settings
    case articles
    case detailArticles(id: String)
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .users: return "Users"
        case .about: return "About"
        case .messages: return "Messages"
        case .settings: return "Settings"
        case .articles: return "Articles"
        case .detailArticles: return "Detail"
        }
    }
}
