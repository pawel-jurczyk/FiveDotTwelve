//
//  ProfilePresenter.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright (c) 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

protocol ProfilePresenterProtocol {
    func presentUserProfile(_ profile: Profile)
    func presentError(_ profile: ProfileError)
    func didStartNetworkRequest()
}

final class ProfilePresenter {
    private weak var viewController: ProfileViewControllerProtocol?
    
    init(viewController: ProfileViewControllerProtocol?) {
        self.viewController = viewController
    }
}

extension ProfilePresenter: ProfilePresenterProtocol {
    func didStartNetworkRequest() {
        DispatchQueue.main.async {
            self.viewController?.showLoader()
        }
    }
    
    func presentError(_ profile: ProfileError) {
        DispatchQueue.main.async {
            self.viewController?.hideLoader()
            switch profile {
            case .parsingError:
                self.viewController?.showError(message: "Server error, please try again later")
            case .networkError:
                self.viewController?.showError(message: "Network error, please check your connection")
            }
            
        }
    }
    
    func presentUserProfile(_ profile: Profile) {
        DispatchQueue.main.async {
            self.viewController?.hideLoader()
            self.viewController?.presentUserProfile(profile)
        }
    }
}
