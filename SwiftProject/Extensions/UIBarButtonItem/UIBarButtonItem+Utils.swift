//
//  UIBarButtonItem+Utils.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/8.
//  Copyright © 2018 Jivan. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    
    class func createBarbuttonItem(name: String,target: Any?, action: Selector) -> UIBarButtonItem{
        
        let rightBtn = UIButton()
        rightBtn.setImage(UIImage(named: name), for: UIControl.State.normal)
        rightBtn.setImage(UIImage(named: name + "_highlighted"), for: UIControl.State.highlighted)
        // button自适应大小
        rightBtn.sizeToFit()
        rightBtn.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        return UIBarButtonItem(customView:rightBtn)
        
    }
    
}

