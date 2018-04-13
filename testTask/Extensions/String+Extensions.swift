//
//  String+Extensions.swift
//  testTask
//
//  Created by Yuriy T on 08.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

extension String {
    
    func styled(with style: Style.Text, crossOut: Bool = false) -> NSAttributedString {
        return attributed(font: style.font, color: style.color, crossOut: crossOut)
    }
    
    func height(withWidth width: CGFloat, font: Font) -> CGFloat {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
}

private extension String {
    func attributed(font: Font, color: Color, crossOut: Bool = false) -> NSAttributedString {
        var attributes: Dictionary<NSAttributedStringKey, Any> = Dictionary()
        attributes[NSAttributedStringKey.font] = font
        attributes[NSAttributedStringKey.foregroundColor] = color
        if crossOut {
            attributes[NSAttributedStringKey.strikethroughStyle] = 1
            attributes[NSAttributedStringKey.baselineOffset] = 0
        }
        
        return NSAttributedString(string: self, attributes: attributes)
    }
}
