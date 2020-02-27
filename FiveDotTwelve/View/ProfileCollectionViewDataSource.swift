//
//  ProfileCollectionViewDataSource.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

class ProfileCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var profile: Profile?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard profile != nil else { return 0 }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let profile = profile else { return 0 }
        switch section {
        case 0, 1:
            return 1
        case 2:
            return profile.photosURLs.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileInfoCollectionViewCell.self),
                                                          for: indexPath)
            guard let profileCell = cell as? ProfileInfoCollectionViewCell,
                let profile = profile else {
                    return cell
            }
            profileCell.profile = ProfileViewModel(profile: profile)
            return profileCell
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SegmentsCollectionViewCell.self),
                                                      for: indexPath)
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self),
                                                          for: indexPath)
            guard let photoCell = cell as? PhotoCollectionViewCell else {
                return cell
            }
            photoCell.imageURL = self.profile?.photosURLs[indexPath.row]
            return photoCell
        default:
            return UICollectionViewCell()
        }
    }
}

extension ProfileCollectionViewDataSource: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let requests: [URLRequest] = indexPaths
            .filter { $0.section == 2 }
            .compactMap {
                guard let url = profile?.photosURLs[$0.row] else { return nil }
                return URLRequest(url: url)
        }
        UIImageView.af.sharedImageDownloader.download(requests)
    }

    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
