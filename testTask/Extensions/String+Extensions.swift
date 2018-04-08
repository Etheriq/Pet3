//
//  String+Extensions.swift
//  testTask
//
//  Created by Yuriy T on 08.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

extension String {
    
    func styled(with style: Style.Text) -> NSAttributedString {
        return attributed(font: style.font, color: style.color)
    }
}

private extension String {
    func attributed(font: Font, color: Color) -> NSAttributedString {
        var attributes: Dictionary<NSAttributedStringKey, Any> = Dictionary()
        attributes[NSAttributedStringKey.font] = font
        attributes[NSAttributedStringKey.foregroundColor] = color
        return NSAttributedString(string: self, attributes: attributes)
    }
}
