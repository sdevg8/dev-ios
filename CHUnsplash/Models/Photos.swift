//
//  Photos.swift
//  CHUnsplash
//
//  Created by user on 06/04/21.
//

import Foundation

struct Photos: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
