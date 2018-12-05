//
//  CarouselCell.swift
//  Shudder
//
//  Created by Suru Layé on 12/3/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import UIKit

class CarouselTableCell: UITableViewCell {
    @IBOutlet weak var carouselView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CarouselTableCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        carouselView.delegate = dataSourceDelegate
        carouselView.dataSource = dataSourceDelegate
        
        carouselView.tag = row
        carouselView.setContentOffset(carouselView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        carouselView.reloadData()
    }
}
