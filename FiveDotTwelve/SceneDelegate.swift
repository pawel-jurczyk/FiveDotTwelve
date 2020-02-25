//
//  SceneDelegate.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ProfileBuilder.buildProfileModule()
        window?.makeKeyAndVisible()
    }
}

