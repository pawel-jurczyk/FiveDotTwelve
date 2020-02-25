//
//  ProfileBuilder.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

protocol ProfileBuilderProtocol {
    static func buildProfileModule() -> ProfileViewController
}

enum ProfileBuilder: ProfileBuilderProtocol {
    enum Constants {
        static let profileStoryboard = "Profile"
    }
    
    static func buildProfileModule() -> ProfileViewController {
        let profileStoryboard = UIStoryboard(name: Constants.profileStoryboard, bundle: nil)
        let viewController = profileStoryboard.instantiateInitialViewController() as? ProfileViewController ?? ProfileViewController()
        let presenter = ProfilePresenter(viewController: viewController)
        let interactor = ProfileInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        
        return viewController
    }
}
