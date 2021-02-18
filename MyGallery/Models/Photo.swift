//
//  Photo.swift
//  MyGallery
//
//  Created by Deepak Dixit on 17/02/21.
//  Copyright © 2021 Deepak Dixit. All rights reserved.
//

import UIKit
/**
    This is struct modal class of photos.
 
    In this modal is creating using Coding key and data coming from server.
 */
struct Photo: Codable {
    var albumId:Int?
    var id:Int?
    var title:String?
    var url:String?
    var thumbnailUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case albumId = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailUrl = "thumbnailUrl"
    }
    
    
}
