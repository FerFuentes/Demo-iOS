//
//  ContentView.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            ForEach(viewModel.users, id: \.id) { user in
                Text("\(user.name)")
            }
            
            Button {
                Task {
                    await viewModel.fetchUsers()
                }
            } label: {
                Text("Get Users")
            }
            
            
        }.padding()
    }
}

#Preview {
    ContentView()
}
