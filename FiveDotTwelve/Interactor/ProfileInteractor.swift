//
//  ProfileInteractor.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright (c) 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

protocol ProfileInteractorProtocol {
    func viewDidLoad()
    func refresh()
}
protocol ProfileDataStore {
    var profile: Profile? { get }
}

final class ProfileInteractor: ProfileDataStore {
    private var presenter: ProfilePresenterProtocol?
    private let worker: ProfileWorkerProtocol
    var profile: Profile?
    
    init(presenter: ProfilePresenterProtocol,
         worker: ProfileWorkerProtocol = ProfileWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    @objc func refresh() {
        worker.downloadUserProfile(completion: processUserProfileCompletion(result:))
    }
    
    func viewDidLoad() {
        presenter?.didStartNetworkRequest()
        worker.downloadUserProfile(completion: processUserProfileCompletion(result:))
    }
    
    private func processUserProfileCompletion(result: Result<Profile, ProfileError>) {
        switch result {
        case .success(let profile):
            self.profile = profile
            presenter?.presentUserProfile(profile)
        case .failure(let error):
            presenter?.presentError(error)
        }
    }
}
