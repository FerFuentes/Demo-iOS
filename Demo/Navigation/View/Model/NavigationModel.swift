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

enum NavigationKey: String, Decodable {
    case home = "Home"
    case users = "Users"
    case about = "About"
    case messages = "Messages"
    case settings = "Settings"
}
