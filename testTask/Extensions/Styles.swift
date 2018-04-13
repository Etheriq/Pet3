//
//  Styles.swift
//  testTask
//
//  Created by Yuriy T on 08.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import Foundation

struct Style {
    
    // MARK: - Text
    struct Text {
        
        /// Public properties
        let color: Color
        let font: Font
        
        /// Default Text styles
        static let regular: Text = {
            return Text(color: Color.SharedColors.black, font: Font(name: "Ubuntu", size: 14)!)
        }()
        
        static let featureWithCrossOut: Text = {
            return Text(color: Color.SharedColors.gray, font: Font(name: "Ubuntu", size: 15)!)
        }()
        
        static let selectedItem: Text = {
            return Text(color: Color.SharedColors.gray_noSelectedFont, font: Font(name: "Ubuntu", size: 14)!)
        }()
        static let noSelectedMessage: Text = {
            return Text(color: Color.SharedColors.gray_noSelectedFont, font: Font(name: "Ubuntu", size: 14)!)
        }()
        
        static let bold: Text = {
            return Text(color: Color.SharedColors.black, font: Font(name: "Ubuntu-Bold", size: 16)!)
        }()
        
    }
}
