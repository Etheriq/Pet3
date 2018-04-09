//
//  NSAttributedString+Extension.swift
//  testTask
//
//  Created by Yuriy T on 09.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func height(withWidth width: CGFloat, andNumberOfLines: Int = 1) -> CGFloat {
//        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
//        let actualSize = boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
//        return ceil(actualSize.height)
        
        let label = UILabel()
        label.frame.size = CGSize(width: width, height: 1)
        label.numberOfLines = andNumberOfLines
        label.attributedText = self
        label.sizeToFit()
        
        return ceil(label.frame.size.height)
    }
}
