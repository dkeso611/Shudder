//
//  DataManager.swift
//  Shudder
//
//  Created by Suru Layé on 12/1/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import Foundation

//let apiKey = "7828b37d96b8876984ef653881261b34"

class  FlickrDataManager {
    
   fileprivate func getFlickrImageURL(flickrUrl: FlickrURLs, _ size: String = "m") -> URL? {
        guard let imageURL =  URL(string: "https://farm\(flickrUrl.farm).staticflickr.com/\(flickrUrl.server)/\(flickrUrl.id)_\(flickrUrl.secret)_\(size).jpg")
            else {
                return nil
        }

        return imageURL
    }

    
    func getFlickrImagesArray(completion: @escaping ([Photo]) -> ()) {
        FlickrApiClient.getFlickrImagesApi(completion: {
            guard let flickrUrlArray = $0.photos?.photo else {
                return
            }
            
            let imagesUrlArray = flickrUrlArray.compactMap({ self.getFlickrImageURL(flickrUrl: $0, "m")})
            let imageDataArray = imagesUrlArray.compactMap({ try? Data(contentsOf: $0) })
            
            var photoArray =  [Photo]()
            
            for i in 0..<min(imagesUrlArray.count, imageDataArray.count) {
                photoArray.append(Photo(flickrImageURL: imagesUrlArray[i], flickrImageData: imageDataArray[i]))
            }
            
            completion(photoArray)
        })
    }
    
    
        
       
}

