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
                ForEach(model.users.sorted { $0.name < $1.name }, id: \.id) { user in
                    Text("\(user.name)")
                }
            }
            
        }.alert(isPresented: $model.showAlertError.show, content: {
            
            switch model.showAlertError.requestError {
                
            case .internetConnection(let message):
                Alert(title: Text("Error"), message: Text(message), primaryButton: .default(Text("Try again"), action: {
                    Task {
                        await model.fetchUsers()
                    }
                }), secondaryButton: .default(Text("OK"))
                )
            default:
                Alert(
                    title: Text("Error"),
                    message: Text("\(model.showAlertError.requestError?.customMessage ?? "Unknown error")"),
                    dismissButton: .default(Text("OK"))
                )
            }
           
            
        }).redacted(reason: model.loading ? .placeholder : .init())
            .refreshable {
            Task {
                await model.fetchUsers()
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await model.fetchUsers()
                    }
                } label: {
                    Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90")
                        .renderingMode(.template)
                        .resizable()
                }
            }
        }.task {
            await model.fetchUsers()
        }

    }
}

#Preview {
    UsersView()
}
