//
//  ProfileViewModelSpec.swift
//  FiveDotTwelveTests
//
//  Created by Pawel on 27/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

@testable import FiveDotTwelve

import Quick
import Nimble

class ProfileViewModelSpec: QuickSpec {
    override func spec() {
        describe("The Profile ViewModel") {
            context("for a given Profile 1") {
                it("needs to return ViewModel with expected values") {
                    let profile = Profile(name: " Grzegorz ",
                                          title: "Photographer, Traveller",
                                          avatarURL: URL(string: "www.example.com")!,
                                          imageURL: URL(string: "www.example.com")!,
                                          followersCount: 223_444,
                                          postsCount: 123,
                                          photosURLs: [])
                    let viewModel = ProfileViewModel(profile: profile)
                    expect(viewModel.name).to(equal("Grzegorz"))
                    expect(viewModel.title).to(equal("Photographer,\nTraveller"))
                    expect(viewModel.avatarURL).to(equal(profile.avatarURL))
                    expect(viewModel.imageURL).to(equal(profile.imageURL))
                    expect(viewModel.followersCount).to(equal("223k"))
                    expect(viewModel.postsCount).to(equal("123"))
                    expect(viewModel.photosURLs).to(equal(profile.photosURLs))
                }
            }
            context("for a given Profile 2") {
                it("needs to return ViewModel with expected values") {
                    let profile = Profile(name: "Grzegorz Brzeczyszczykiewicz",
                                          title: "Photographer, Traveller, Juggler",
                                          avatarURL: URL(string: "www.example.com")!,
                                          imageURL: URL(string: "www.example.com")!,
                                          followersCount: 223_123_222,
                                          postsCount: 123_422_333_322,
                                          photosURLs: [])
                    let viewModel = ProfileViewModel(profile: profile)
                    expect(viewModel.name).to(equal("Grzegorz Brzeczyszczykiewicz"))
                    expect(viewModel.title).to(equal("Photographer,\nTraveller"))
                    expect(viewModel.avatarURL).to(equal(profile.avatarURL))
                    expect(viewModel.imageURL).to(equal(profile.imageURL))
                    expect(viewModel.followersCount).to(equal("223m"))
                    expect(viewModel.postsCount).to(equal("123b"))
                    expect(viewModel.photosURLs).to(equal(profile.photosURLs))
                }
            }
        }
    }
}
