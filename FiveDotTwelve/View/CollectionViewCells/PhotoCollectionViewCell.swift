//
//  PhotoCollectionViewCell.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    var imageURL: URL? {
        didSet {
            guard let imageURL = imageURL else { return }
            imageView.af.setImage(withURL: imageURL)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.af.cancelImageRequest()
    }
}
