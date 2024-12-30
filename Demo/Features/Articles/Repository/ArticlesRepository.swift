//
//  HoseRepository.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import NetworkLibrary
import SwiftUI

protocol ArticlesRepository {
    func fetchArticles() async throws -> [Article]
    func fetchArticleDetails(id: String) async throws -> Article
    var loading: Published<Bool>.Publisher { get }
}

class ArticlesRepositoryImpl: ArticlesRepository, Client {
    
    static let shared = ArticlesRepositoryImpl()

    @Published private var _loading = false
    var loading: Published<Bool>.Publisher { $_loading }
    
    func fetchArticles() async throws -> [Article] {
        _loading = true
        let endpoint = Endpoints.articles
        let response = await sendRequest(endpoint: endpoint, responseModel: [Article].self)
        
        switch response {
        case .success(let houses):
            _loading = false
            return houses
        case .failure(let error):
            _loading = false
            throw error
        }
    }
    
    func fetchArticleDetails(id: String) async throws -> Article {
        let endpoint = Endpoints.articleDetail(id: id)
        let response = await sendRequest(endpoint: endpoint, responseModel: Article.self)
        
        switch response {
        case .success(let article):
            return article
        case .failure(let error):
            throw error
        }
    }
}
