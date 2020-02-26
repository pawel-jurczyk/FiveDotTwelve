//
//  SegmentsCollectionViewCell.swift
//  FiveDotTwelve
//
//  Created by Pawel on 25/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

class SegmentsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var postsLabel: UILabel! {
        didSet {
            postsLabel.attributedText = "POSTS".attributedString(withKern: 2)
        }
    }
    @IBOutlet var photosLabel: UILabel! {
        didSet {
            photosLabel.attributedText = "PHOTOS".attributedString(withKern: 2)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.init(named: "SegmentBackground")
    }
}
