//
//  RoundedButton.swift
//  testTask
//
//  Created by Yuriy T on 13.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
