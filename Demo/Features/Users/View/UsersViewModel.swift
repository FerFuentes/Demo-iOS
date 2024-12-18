//
//  ViewModel.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//
import SwiftUI
import Combine
import NetworkLibrary

@MainActor
class UsersViewModel: ObservableObject {
    @Published var loading = false
    @Published var users: [User] = []
    @Published var showAlertError: (show: Bool, requestError: RequestError?) = (show: false, requestError: nil)
    
    var cancellables = Set<AnyCancellable>()
    let repository: UserRepositoryImpl = {
        return UserRepositoryImpl.shared
    }()
    
    init() {
        repository.loading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] show in
                guard let self = self else { return }
                self.loading = show
            }.store(in: &cancellables)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    func fetchUsers() async {
        do {
            let response = try await repository.fetchUsers()
            users = response
        } catch let error as RequestError {
            showAlertError = (show: true, requestError: error)
        } catch {
            print(error)
        }
    }
}
