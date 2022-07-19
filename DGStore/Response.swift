//
//  Response.swift
//  DGStore
//
//  Created by Mercen on 2022/07/19.
//

import Foundation

public struct serverData: Decodable {
    let list: [dataArray]
}

public struct dataArray: Decodable {
    let title: String
    let developer: String
    let description: String
    let image: String
    let framework: String
}
