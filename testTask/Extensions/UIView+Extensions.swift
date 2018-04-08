//
//  UIView+Extensions.swift
//  testTask
//
//  Created by Yuriy T on 08.04.2018.
//  Copyright © 2018 Yuriy T. All rights reserved.
//

import UIKit

extension UIView {
    
    public class func fromNib(_ nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    public class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T {
        return fromNib(nibNameOrNil, type: T.self)!
    }
    
    public class func fromNib<T : UIView>(_ nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String = nibNameOrNil ?? nibName
        let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil)!
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    public class var nibName: String {
        return "\(self)".components(separatedBy: ".").first ?? ""
    }
    
    public class var nib: UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
}
