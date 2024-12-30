//
//  ArticleDetail.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

struct ArticleDetail: Decodable {
    let id: String
    let name: String
    let imagesURL: [String]
    let description: String
}
