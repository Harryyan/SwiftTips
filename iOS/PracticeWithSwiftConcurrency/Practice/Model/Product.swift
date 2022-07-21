//
//  UserData.swift
//  Practice
//
//  Created by Harry Yan on 18/07/22.
//

import Foundation

struct Products: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let title: String
    let description: String
}
