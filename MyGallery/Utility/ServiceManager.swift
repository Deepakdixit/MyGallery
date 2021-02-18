//
//  NetworkManager.swift
//  MyGallery
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit

/**
    Enum of URL which is provide the complete URL for fetching photos.
*/
enum URLs: String {
    case photos = "/photos"
    var string: String {
        return "http://jsonplaceholder.typicode.com" + self.rawValue
    }
    var url: URL? {
        return URL(string: self.string)
    }
}

/**
    This is Network Layer class.
*/
class ServiceManager: NSObject {
    
    public static let shared = ServiceManager();
    private let session = URLSession(configuration:.default)
    private override init() {}
    
    /**
     A private function that create a custom URLRequest
     
     - Parameter url: Url is Enum for creating a request
     - Return : A URLRequest that is completely customize.
     */
    private func createRequest(_ url:URLs) -> URLRequest {
        let request = URLRequest(url: url.url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        return request
    }
    
    /**
     This function is to fetch Photo's data from server.
     In this function first I am checking network reachability.
     
     - Return: This function callback Data or error from server
     
     - Parameter callback: Its a completetion handler, And it will be called after Asyncronous request respond.
     - Parameter data: Its returns a array of photo in call back.
     - Parameter error: Its returns a error of request if any error occurs while fetching.
 */
    
    func fetchPhotos(_ callback:@escaping(_ data:[Photo]?,_ error:Error?)-> Void) {
        if Constants.shared.reachability.connection == .none {
            callback(nil, nil)
            return;
        }
        session.dataTask(with: self.createRequest(.photos)) { (data, response, error) in
            
            if let data = data {
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
                DispatchQueue.main.async {
                    callback(photos, error)
                }
            } else {
                DispatchQueue.main.async {
                    callback(nil, error)
                }
            }
            }.resume()
    }
}

