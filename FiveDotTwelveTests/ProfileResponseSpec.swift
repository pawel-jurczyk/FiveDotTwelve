//
//  ProfileResponseSpec.swift
//  FiveDotTwelveTests
//
//  Created by Pawel on 27/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

@testable import FiveDotTwelve

import Quick
import Nimble

class ProfileResponseSpec: QuickSpec {
    
    let jsonString = """
    {
      "profile": {
        "name": "Grzegorz ",
        "title": "PHOTOGRAPHER, TRAVELER",
        "avatar_image": "https://store.playstation.com/store/api/chihiro/00_09_000/container/PL/en/999/EP0149-CUSA09988_00-AV00000000000002/1553528383000/image?w=480&h=480&bg_color=000000&opacity=100&_version=00_09_000",
        "image": "https://farm3.staticflickr.com/2830/32736010994_7eb6d4ab8f_k.jpg",
        "followers_count": 230992,
        "posts_count": 13,
        "photos": [
          "https://cdn.pixabay.com/photo/2019/10/23/20/52/eye-4572820_1280.jpg",
          "https://cdn.pixabay.com/photo/2015/07/27/19/47/turtle-863336_1280.jpg",
          "https://cdn.pixabay.com/photo/2014/07/01/12/35/taxi-cab-381233_1280.jpg"
        ]
      }
    }
    """
    
    override func spec() {
        describe("The Profile Reponse") {
            context("for a given JSON data") {
                let data = self.jsonString.data(using: .utf16)!
                it("should correctly parse the data") {
                    guard let profileResponse = try? JSONDecoder().decode(ProfileResponse.self, from: data) else {
                        fail()
                        return
                    }
                    expect(profileResponse.profile.name).to(equal("Grzegorz "))
                    expect(profileResponse.profile.title).to(equal("PHOTOGRAPHER, TRAVELER"))
                    let expectedAvatarURL = URL(string: "https://store.playstation.com/store/api/chihiro/00_09_000/container/PL/en/999/EP0149-CUSA09988_00-AV00000000000002/1553528383000/image?w=480&h=480&bg_color=000000&opacity=100&_version=00_09_000")
                    expect(profileResponse.profile.avatarURL).to(equal(expectedAvatarURL))
                    let expectedImageURL = URL(string: "https://farm3.staticflickr.com/2830/32736010994_7eb6d4ab8f_k.jpg")
                    expect(profileResponse.profile.imageURL).to(equal(expectedImageURL))
                    expect(profileResponse.profile.followersCount).to(equal(230992))
                    expect(profileResponse.profile.postsCount).to(equal(13))
                    let expectedPhotos = [
                      URL(string: "https://cdn.pixabay.com/photo/2019/10/23/20/52/eye-4572820_1280.jpg")!,
                      URL(string: "https://cdn.pixabay.com/photo/2015/07/27/19/47/turtle-863336_1280.jpg")!,
                      URL(string: "https://cdn.pixabay.com/photo/2014/07/01/12/35/taxi-cab-381233_1280.jpg")!
                    ]
                    expect(profileResponse.profile.photosURLs).to(equal(expectedPhotos))
                }
                
                
            }
        }
    }
    
}
