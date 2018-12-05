//
//  PhotoTableCell.swift
//  Shudder
//
//  Created by Suru Layé on 12/3/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import UIKit

class PhotoTableCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photoArray =  [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}

extension PhotoTableCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow section: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = section
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
}
