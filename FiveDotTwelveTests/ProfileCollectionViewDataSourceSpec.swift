//
//  ProfileCollectionViewDataSource.swift
//  FiveDotTwelveTests
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import FiveDotTwelve
import Nimble
import Quick

class ProfileCollectionViewDataSourceSpec: QuickSpec {
    let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewLayout())
    override func spec() {
        describe("Before the profile is set") {
            let dataSource = ProfileCollectionViewDataSource()
            context("the numberOfSections") {
                it("should be 0") {
                    expect(dataSource.numberOfSections(in: self.collectionView)).to(equal(0))
                }
            }
            context("the numberOfItemsInSection 0") {
                it("should be 0") {
                    let count = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
                    expect(count).to(equal(0))
                }
            }
        }
        describe("After the profile is set") {
            let profile = Profile(name: "",
                                  title: "",
                                  avatarURL: URL(string: "www.example.com")!,
                                  imageURL: URL(string: "www.example.com")!,
                                  followersCount: 1,
                                  postsCount: 1,
                                  photosURLs: [URL(string: "www.example.com")!,
                                               URL(string: "www.example.com")!,
                                               URL(string: "www.example.com")!])
            let dataSource = ProfileCollectionViewDataSource()
            dataSource.profile = profile
            context("the numberOfSections") {
                it("should be 3") {
                    expect(dataSource.numberOfSections(in: self.collectionView)).to(equal(3))
                }
            }
            context("the numberOfItemsInSection 0") {
                it("should be 1") {
                    let count = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 0)
                    expect(count).to(equal(1))
                }
            }
            context("the numberOfItemsInSection 1") {
                it("should be 1") {
                    let count = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 1)
                    expect(count).to(equal(1))
                }
            }
            context("the numberOfItemsInSection 2") {
                it("should be equal the number of photos") {
                    let count = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 2)
                    expect(count).to(equal(profile.photosURLs.count))
                }
            }
            context("the numberOfItemsInSection 3") {
                it("should be 0") {
                    let count = dataSource.collectionView(self.collectionView, numberOfItemsInSection: 3)
                    expect(count).to(equal(0))
                }
            }
        }
    }
}
