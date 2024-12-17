//
//  ContentView.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//

import SwiftUI

struct UsersView: View {
    @StateObject var model = UsersViewModel()
    
    var body: some View {
        
        List {
            Section {
                ForEach(model.users, id: \.id) { user in
                    Text("\(user.name)")
                }
            }
            
        }.redacted(reason: model.loading ? .placeholder : .init())
            .refreshable {
            Task {
                await model.fetchUsers()
            }
        }
        .navigationBarItems(trailing: Button(action: {
            Task {
                await model.fetchUsers()
            }
        }) {
            Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                .renderingMode(.template)
                .resizable()
        })

    }
}

#Preview {
    UsersView()
}
