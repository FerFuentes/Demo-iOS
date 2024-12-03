//
//  ViewModel.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var users: [User] = []
    
    let repository: UserRepositoryImpl = {
        return UserRepositoryImpl.shared
    }()
    
    func fetchUsers() async {
        do {
            let response = try await repository.fetchUsers()
            users = response
        } catch {
            debugPrint(error)
        }
    }
}
