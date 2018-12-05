//
//  PhotoVM.swift
//  Shudder
//
//  Created by Suru Layé on 12/3/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import Foundation
import UIKit

struct  PhotoViewModel {
    var image: UIImage?
    
    init(photo: UIImage) {
        self.image = photo
    }
}
