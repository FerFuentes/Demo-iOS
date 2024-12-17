//
//  Repository.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//

import NetworkLibrary
import SwiftUI

protocol UserRepository {
    func fetchUsers() async throws -> [User]
    var loading: Published<Bool>.Publisher { get }
}

class UserRepositoryImpl: UserRepository, Client {
    
    private static let _shared = UserRepositoryImpl()
    static var shared: UserRepositoryImpl {
        return _shared
    }
    
    @Published private var _loading = false
    var loading: Published<Bool>.Publisher { $_loading }
    
    func fetchUsers() async throws -> [User] {
        _loading = true
        let endpoint = Endpoints.users
        let response = await sendRequest(endpoint: endpoint, responseModel: [User].self)
        
        switch response {
        case .success(let users):
            _loading = false
            return users
        case .failure(let error):
            _loading = false
            throw error
        }
    }
}
