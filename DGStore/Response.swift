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
    let thumb: String
    let framework: String
    let github: String
    let download: downloadDatas
}

public struct downloadDatas: Decodable {
    let windows: String
    let macos: String
    let linux: String
    let android: String
    let ios: String
}
