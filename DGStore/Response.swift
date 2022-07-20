//
//  Response.swift
//  DGStore
//
//  Created by Mercen on 2022/07/19.
//

import Foundation

public struct serverData: Decodable {
    let list: [dataArray]
    let page_size: Int
}

public struct dataArray: Decodable {
    let title: String
    let developer: String
    let description: String
    let thumb: String
    let framework: String
    let github: String
    let downloads: [downloadDatas]
}

public struct downloadDatas: Decodable {
    let fileName: String
    let platformType: String
}
