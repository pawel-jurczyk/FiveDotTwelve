//
//  ProfileInteractorSpec.swift
//  FiveDotTwelveTests
//
//  Created by Pawel on 27/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import XCTest
@testable import FiveDotTwelve
import Nimble
import Quick

class ProfileInteractorSpec: QuickSpec {
    override func spec() {
        describe("When the Interactor is initialized") {
            var workerMock: ProfileWorkerMock!
            var presenterMock: ProfilePresenterMock!
            var interactor: ProfileInteractor!
            beforeEach {
                workerMock = ProfileWorkerMock()
                presenterMock = ProfilePresenterMock()
                interactor = ProfileInteractor(presenter: presenterMock, worker: workerMock)
            }
            context("on viewDidLoad") {
                it("should call these methods") {
                    interactor.viewDidLoad()
                    expect(workerMock.didCallDownloadUserProfile).to(equal(true))
                    expect(presenterMock.didCallDidStartNetworkRequest).to(equal(true))
                }
            }
            context("on refresh") {
                it("should call these methods") {
                    interactor.refresh()
                    expect(workerMock.didCallDownloadUserProfile).to(equal(true))
                }
            }
        }
    }
}

class ProfilePresenterMock: ProfilePresenterProtocol {
    var didCallPresentUserProfile = false
    var didCallPresentError = false
    var didCallDidStartNetworkRequest = false
    func presentUserProfile(_ profile: Profile) {
        didCallPresentUserProfile = true
    }
    
    func presentError(_ profile: ProfileError) {
        didCallPresentError = true
    }
    
    func didStartNetworkRequest() {
        didCallDidStartNetworkRequest = true
    }
}

class ProfileWorkerMock: ProfileWorkerProtocol {
    var didCallDownloadUserProfile = false
    func downloadUserProfile(completion: @escaping ((Result<Profile, ProfileError>) -> Void)) {
        didCallDownloadUserProfile = true
    }
}
