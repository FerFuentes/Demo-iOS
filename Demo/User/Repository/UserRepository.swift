//
//  Repository.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//

import NetworkLibrary

protocol UserRepository {
    func fetchUsers() async throws -> [User]
}

class UserRepositoryImpl: UserRepository, Client {
    
    private static let _shared = UserRepositoryImpl()
    static var shared: UserRepositoryImpl {
        return _shared
    }
    
    func fetchUsers() async throws -> [User] {
        let endpoint = Endpoints.users
        let response = await sendRequest(endpoint: endpoint, responseModel: [User].self)
        
        switch response {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
}
