//
//  ViewControllerDelegate.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/21.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class ViewControllerDelegate: AppDelegateType {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIApplication.shared.delegate?.window
        window??.backgroundColor = UIColor.white
        let root  = JHBaseTabBarController()
        window??.rootViewController = root
        window??.makeKeyAndVisible()
        
        return true
    }
}

