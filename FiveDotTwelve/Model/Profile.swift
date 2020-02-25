//
//  Profile.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import Foundation

struct Profile: Decodable {
    let name: String
    let title: String
    let avatarURL: URL
    let imageURL: URL
    let followersCount: Int
    let postsCount: Int
    let photosURLs: [URL]
    
    private enum CodingKeys: String, CodingKey {
        case name
        case title
        case avatarURL = "avatar_image"
        case imageURL = "image"
        case followersCount = "followers_count"
        case postsCount = "posts_count"
        case photosURLs = "photos"
    }
}
