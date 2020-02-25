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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0, 1:
            return 1
        case 2:
            return profile?.photosURLs.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProfileInfoCollectionViewCell.self),
                                                      for: indexPath)
            guard let profileCell = cell as? ProfileInfoCollectionViewCell else { return cell }
            profileCell.profile = profile
            return profileCell
        case 1:
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SegmentsCollectionViewCell.self),
                                                      for: indexPath)
        case 2:
            return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self),
                                                      for: indexPath)
        default:
            return UICollectionViewCell()
        }
    }
}
