//
//  FlickrModels.swift
//  Shudder
//
//  Created by Suru Layé on 12/1/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import Foundation

struct FlickrImageResult: Codable {
    let photos : FlickrPagedImageResult?
    let stat: String
}

struct FlickrPagedImageResult: Codable {
    let photo : [FlickrURLs]
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
}

struct FlickrURLs: Codable {
    let id : String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    
}
