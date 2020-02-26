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
    
    @IBOutlet var followButton: UIButton! {
        didSet {
            configureFollowButton()
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postsCountLabel: UILabel!
    @IBOutlet var followersCountLabel: UILabel!
    @IBOutlet var postsLabel: UILabel! {
        didSet {
            postsLabel.attributedText = "POSTS".attributedString(withKern: 0.55)
        }
    }
    @IBOutlet var followersLabel: UILabel! {
        didSet {
            followersLabel.attributedText = "FOLLOWERS".attributedString(withKern: 0.55)
        }
    }
    @IBOutlet var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.bounds.height / 2
        }
    }
    @IBOutlet var backgroundImage: UIImageView!
    
    var profile: ProfileViewModel? {
        didSet {
            guard let profile = profile else { return }
            
            titleLabel.attributedText = profile.title.attributedString(withKern: 0.55)
            nameLabel.attributedText = profile.name.attributedString(withKern: 0.55, color: Color.nameLabel)
            postsCountLabel.attributedText = profile.postsCount.attributedString(withKern: 0.25)
            followersCountLabel.attributedText = profile.followersCount.attributedString(withKern: 0.25)
            profileImage.af.setImage(withURL: profile.avatarURL)
            backgroundImage.af.setImage(withURL: profile.imageURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.af.cancelImageRequest()
        backgroundImage.af.cancelImageRequest()
    }
    
    private func configureFollowButton() {
        let title = "+ Follow".attributedString(withKern: 1.6)
        followButton.setAttributedTitle(title, for: .normal)
        followButton.layer.cornerRadius = followButton.bounds.height / 2
        followButton.layer.borderWidth = 2
        followButton.layer.borderColor = Color.followButtonBorder.cgColor
    }
}
