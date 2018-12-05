//
//  PhotoModel.swift
//  Shudder
//
//  Created by Suru Layé on 12/3/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import Foundation

struct Photo {
    var flickrImageURL: URL
    var flickrImageData: Data
    
    init(flickrImageURL: URL, flickrImageData: Data) {
        self.flickrImageURL = flickrImageURL
        self.flickrImageData = flickrImageData
    }
}
