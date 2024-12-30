//
//  Endpoints.swift
//  Demo
//
//  Created by Fernando Fuentes on 03/12/24.
//

import NetworkLibrary

import Foundation

public enum Endpoints {
    case test
    case users
    case articles
    case articleDetail(id: String)
}

extension Endpoints: Base {
    
    public var scheme: String {
        return "https"
    }

    public var host: String {
        return "674f4990bb559617b26ebb4c.mockapi.io"
    }
    
    public var version: String {
        return "/"
    }
    
    public var header: [String: String]? {
        var headers: [String: String]? = [
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        
        switch self {
        case .test:
            headers?[""] = ""
            return headers
        default: return headers
        }
    }
    
    public var method: RequestMethod {
        switch self {
        case .test, .users, .articles, .articleDetail: return .get
        }
    }
    
    public var path: String {
        switch self {
        case .test: return "test"
        case .users: return "users"
        case .articles: return "articles"
        case .articleDetail(let id): return "articles/\(id)"
        }
    }
    
    public var parameters: [URLQueryItem]? {
        switch self {
        default: return nil
        }
    }
    
    public var body: Data? {
        switch self {
        default: return nil
        }
    }
    
    public var boundry: String? {
        switch self {
        default: return nil
        }
    }
    
}
