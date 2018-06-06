//
//  Model.swift
//  ViewTube
//
//  Created by Devesh Nema on 6/4/18.
//  Copyright © 2018 Devesh Nema. All rights reserved.
//

import Foundation

class Video: Decodable {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
    var uploadDate: Date?
    var duration: Int?
    
    var channel: Channel?
}

class Channel: Decodable {
    var name: String?
    var profile_image_name: String?
}
