//
//  RoundButton.swift
//  SmartCane
//
//  Created by Shawn Popal on 3/19/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didset{
            self.layer.cornerRadius = cornerRadius
        }
    }
}
