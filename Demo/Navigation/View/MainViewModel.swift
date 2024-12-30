//
//  MainViewModel.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI


class MainViewModel: ObservableObject {
    @Published var  sample: [NavigationModel]  = [
        NavigationModel(id: "1", key: .home, iconURL: "https://cdn-icons-png.flaticon.com/512/2198/2198321.png", action: .openView),
        NavigationModel(id: "2", key: .about, iconURL: "https://cdn-icons-png.flaticon.com/512/3503/3503827.png",action: .openURL(url: "https://www.apple.com", showTitle: true)),
        NavigationModel(id: "3", key: .users, iconURL: "https://cdn-icons-png.flaticon.com/512/1077/1077063.png", action: .openView),
        NavigationModel(id: "4", key: .articles, iconURL: "https://cdn-icons-png.flaticon.com/512/9446/9446889.png", action: .openView)
    ]

}
