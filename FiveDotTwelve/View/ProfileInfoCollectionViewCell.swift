//
//  ProfileInfoCollectionViewCell.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var followButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postsLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var backgroundImage: UIImageView!
    
    var profile: Profile? {
        didSet {
            guard let profile = profile else { return }
            titleLabel.text = profile.title
            nameLabel.text = profile.name
            postsLabel.text = "\(profile.postsCount)"
            followersLabel.text = "\(profile.followersCount)"
            profileImage.af.setImage(withURL: profile.avatarURL)
            backgroundImage.af.setImage(withURL: profile.imageURL)
        }
    }
}
