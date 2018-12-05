//
//  PhotoCollectionViewCell.swift
//  Shudder
//
//  Created by Suru Layé on 12/3/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var viewModel: PhotoViewModel? {
        didSet {
            imageView.image = viewModel?.image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}

