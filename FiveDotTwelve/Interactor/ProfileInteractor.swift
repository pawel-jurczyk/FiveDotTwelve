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
}
protocol ProfileDataStore {
    var profile: Profile? { get }
}

final class ProfileInteractor: ProfileDataStore {
    private var presenter: ProfilePresenterProtocol?
    private let worker = ProfileWorker()
    var profile: Profile?
    
    init(presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
    }
}

extension ProfileInteractor: ProfileInteractorProtocol {
    @objc func viewDidLoad() {
        presenter?.didStartNetworkRequest()
        worker.downloadUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.profile = profile
                self?.presenter?.presentUserProfile(profile)
            case .failure(let error):
                self?.presenter?.presentError(error)
            }
        }
    }
}
