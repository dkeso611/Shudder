//
//  FlickrApiClient.swift
//  Shudder
//
//  Created by Suru Layé on 12/4/18.
//  Copyright © 2018 Suru Layé. All rights reserved.
//

import Foundation

fileprivate let apiKey = "7828b37d96b8876984ef653881261b34"

struct FlickrApiClient {
    
    static fileprivate func getFlickrEndPoint(tags: String) -> URL? {
        
        let host = "https://api.flickr.com"
        let path = "/services/rest//?method=flickr.photos.search"
        let key = "&api_key=\(apiKey)"
        let query = "&tags=\(tags)&per_page=10&format=json&nojsoncallback=1"
        let urlString = host + path + key + query
        
        guard let dataURL = URL(string: urlString) else {
            print("Error unwrapping URL")
            return nil
        }
        
        return dataURL
        
    }
    
     
    
    static func getFlickrImagesApi(completion: @escaping (FlickrImageResult) -> ()) {
        let endpoint =  getFlickrEndPoint(tags: "movieposters")
        
        let task = URLSession.shared.dataTask(with: endpoint!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            
            do {
                
                //Decode data from dataResponse
                let decoder = JSONDecoder()
                let flickrImageResult =  try decoder.decode(FlickrImageResult.self, from: dataResponse)
                
                DispatchQueue.main.async {
                    completion(flickrImageResult)
                }
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    
    }
    
    
}
