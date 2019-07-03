//
//  PayDelegateType.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/3.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class PayDelegate: AppDelegateType {
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        JHPayManager.shared.handleOpen(url)
        return true
    }
    
}
