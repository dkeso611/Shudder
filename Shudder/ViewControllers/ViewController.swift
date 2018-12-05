//
//  ViewController.swift
//  Shudder
//
//  Created by Suru Layé on 12/1/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var featuredView: FeaturedView!
    
    let manager = FlickrDataManager()
    var photoArray = [Photo]()
    var photoGroup = [[Photo]]()
    var heroArray = [Photo]()
    
    var sectionTitleArray = ["Michonne", "Glen", "Every", "One", "Else", "...", "Carl"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = featuredView
        featuredView.tableView.delegate = self
        featuredView.tableView.dataSource = self
        
        manager.getFlickrImagesArray {
            self.photoArray = $0
            self.photoGroup = Array(repeating: $0, count: 7)
            self.heroArray = Array(self.photoArray[0...4])
            
            DispatchQueue.main.async {
                self.featuredView.tableView.reloadData()
            }
            
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.photoGroup.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableCell") as? PhotoTableCell
            else { return UITableViewCell() }
        
        
        if indexPath.section != 0 {
            return cell
        } else {
            guard let carouselCell = tableView.dequeueReusableCell(withIdentifier: "CarouselTableCell", for: indexPath) as? CarouselTableCell
                
                else {
                    return UITableViewCell()
            }
           return carouselCell
            
        }

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        if indexPath.section != 0 {
            guard let photoTableCell = cell as? PhotoTableCell else { return }
            photoTableCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        }
        else {
            guard let carouselCell = cell as? CarouselTableCell else { return }
            carouselCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        }

        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
           return sectionTitleArray[section - 1]
        } else {
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .darkText
            headerView.textLabel?.textColor = .lightGray
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        }
        
        return 175
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag !=  0 {
            return photoGroup[collectionView.tag - 1].count
        } else {
            return heroArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag != 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as?PhotoCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let image = UIImage(data: photoGroup[collectionView.tag - 1][indexPath.item].flickrImageData) else {
                return UICollectionViewCell()
            }
            
            cell.viewModel = PhotoViewModel(photo: image)
            return cell
            
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCell else {
                return UICollectionViewCell()
            }
            
            
            guard  let image = UIImage(data: heroArray[indexPath.item].flickrImageData) else {
                return UICollectionViewCell()
            }
        
           /* Attempt at Hero View
            if collectionView.isDecelerating == true {
                print("test")
                let contentOffsetWhenFullyScrolledRight = collectionView.frame.size.width * (CGFloat(integerLiteral: heroArray.count - 1))
                
                if collectionView.contentOffset.x == contentOffsetWhenFullyScrolledRight {
                    collectionView.scrollToItem(at: NSIndexPath(item: 1, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.left , animated: false)
                    
                    
                } else if collectionView.contentOffset.x == 0 {
                    collectionView.scrollToItem(at: NSIndexPath(item: heroArray.count - 2, section: 0) as IndexPath, at: UICollectionView.ScrollPosition.left , animated: false)
                    print("a")
                }
            }
            */
            
            cell.viewModel = PhotoViewModel(photo: image)
            return cell
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
}
