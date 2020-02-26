//
//  String+Extension.swift
//  FiveDotTwelve
//
//  Created by Pawel on 26/02/2020.
//  Copyright © 2020 Pawel Jurczyk. All rights reserved.
//

import UIKit

extension String {
    func attributedString(withKern kern: Double, color: UIColor? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.kern,
                                      value: kern,
                                      range: fullRange)
        attributedString.addAttribute(.foregroundColor,
                                      value: color ?? Color.labelText as Any,
                                      range: fullRange)
        return attributedString
    }
}
