//
//  ProfileWorker.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright (c) 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

protocol ProfileWorkerProtocol {
    func downloadUserProfile(completion: @escaping ((Result<Profile, ProfileError>) -> Void))
}

final class ProfileWorker {
    private struct Constants {
        static let url = URL(string: "https://fivedottwelve.com/FDT_iOS_rekrutacja_data.json")!
    }
    private let session = URLSession(configuration: .default)
    private var completion: ((Result<Profile, ProfileError>) -> Void)?
}

extension ProfileWorker: ProfileWorkerProtocol {
    func downloadUserProfile(completion: @escaping ((Result<Profile, ProfileError>) -> Void)) {
        self.completion = completion
        let task = session.dataTask(with: Constants.url, completionHandler: handleUserProfileCompletion)
        task.resume()
    }
    
    private func handleUserProfileCompletion(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else  {
            complete(with: .networkError)
            return
        }
        guard let data = data,
            let profileResponse = try? JSONDecoder().decode(ProfileResponse.self, from: data) else {
                complete(with: .parsingError)
                return
        }
        complete(with: profileResponse.profile)
    }
    
    private func complete(with error: ProfileError) {
        completion?(.failure(error))
        completion = nil
    }
    
    private func complete(with profile: Profile) {
        completion?(.success(profile))
        completion = nil
    }
}
