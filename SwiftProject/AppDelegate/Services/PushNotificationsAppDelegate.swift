//
//  PushNotificationsAppDelegate.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/19.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class PushNotificationsAppDelegate: AppDelegateType {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("推送配置")
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("推送相关代码...")
    }
    
    // 其余方法
}
