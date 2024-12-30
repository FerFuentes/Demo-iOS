//
//  HomeModel.swift
//  Demo
//
//  Created by Fernando Fuentes on 19/12/24.
//

import SwiftUI

struct Article: Decodable {
    let id: String
    let name: String
    let imageURL: String
    let description: String
}
