//
//  HomeView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

struct HomeView: View {
    private let navigationManager = NavigationViewsManager.shared
    private let settingsItem = NavigationModel(id: "7", key: .settings, action: .openView)
    
    var body: some View {
        VStack {
            
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: navigationManager.destination(settingsItem)) {
                    Image(systemName: "gear")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 24, height: 24) // Adjust size as needed
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
