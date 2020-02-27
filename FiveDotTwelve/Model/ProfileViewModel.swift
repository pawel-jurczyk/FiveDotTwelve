//
//  ProfileViewModel.swift
//  FiveDotTwelve
//
//  Created by Pawel on 26/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import Foundation

struct ProfileViewModel {
    let name: String
    let title: String
    let avatarURL: URL
    let imageURL: URL
    let followersCount: String
    let postsCount: String
    let photosURLs: [URL]
    
    init(profile: Profile) {
        self.name = profile.name.trimmingCharacters(in: [" "])
        var titleComponents = profile.title.components(separatedBy: ", ")
        let toRemove = titleComponents.count - 2
        if toRemove > 0 {
            titleComponents.removeLast(toRemove)
        }
        self.title = titleComponents.joined(separator: ",\n")
        self.postsCount = "\(ProfileViewModel.formattedCount(profile.postsCount))"
        self.followersCount = "\(ProfileViewModel.formattedCount(profile.followersCount))"
        self.photosURLs = profile.photosURLs
        self.imageURL = profile.imageURL
        self.avatarURL = profile.avatarURL
    }
    
    private static func formattedCount(_ count: Int) -> String {
        if count > 999_999_999 {
            return "\(count / 1_000_000_000)b"
        } else if count > 999_999 {
            return "\(count / 1_000_000)m"
        } else if count > 999 {
            return "\(count / 1_000)k"
        }
        return "\(count)"
    }
}
