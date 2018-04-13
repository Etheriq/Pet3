//
//  HalfRoundedButton.swift
//  testTask
//
//  Created by Yuriy T on 13.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

class HalfRoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.size.height / 2
        layer.masksToBounds = true
    }
}
