//
//  MainView.swift
//  Demo
//
//  Created by Fernando Fuentes on 17/12/24.
//

import SwiftUI

struct MainView: View {
    @StateObject var model = MainViewModel()
    @State var selectedtab: String = "1"
    private let navigationManager = NavigationViewsManager.shared
    
    
    var body: some View {
        TabView(selection: $selectedtab) {
            ForEach(model.sample) { tabItem in
                
                navigationManager.destination(tabItem)
                    .tag(tabItem.id)
                    .tabItem {
                        
                        Label {
                            Text(tabItem.key.title)
                            
                        } icon: {
                            IconView(
                                scale: 20,
                                applyforegroundColor: (apply: true, color: .gray),
                                iconURL: tabItem.iconURL
                            )
                        }
                        
                    }
            }
        }.tint(.blue)
            
    }
}

#Preview {
    MainView()
}
