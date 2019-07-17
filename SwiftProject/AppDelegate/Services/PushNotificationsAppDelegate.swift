//
//  PushNotificationsAppDelegate.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/19.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import UserNotifications
class PushNotificationsAppDelegate: AppDelegateType{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self .registerJpush(withOptions: launchOptions)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        handleRemoteNotification(userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(.newData)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        handleRemoteNotification(userInfo)
        JPUSHService.handleRemoteNotification(userInfo)
    }
    
    // 其余方法
    func registerJpush(withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if #available(iOS 10.0, *){
            let entiity = JPUSHRegisterEntity()
            entiity.types = Int(JPAuthorizationOptions.alert.rawValue |
                JPAuthorizationOptions.badge.rawValue |
                JPAuthorizationOptions.sound.rawValue)
            JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self )
        } else if #available(iOS 8.0, *) {
            let types = UIUserNotificationType.badge.rawValue |
                UIUserNotificationType.sound.rawValue |
                UIUserNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: types, categories: nil)
        }else {
            let type = UIRemoteNotificationType.badge.rawValue |
                UIRemoteNotificationType.sound.rawValue |
                UIRemoteNotificationType.alert.rawValue
            JPUSHService.register(forRemoteNotificationTypes: type, categories: nil)
        }
        //MARK: 这里添加APPKEY
        JPUSHService.setup(withOption: launchOptions, appKey:"", channel: "Publish channel", apsForProduction: true)
        
    }
}

extension PushNotificationsAppDelegate:JPUSHRegisterDelegate
{
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            handleRemoteNotification(userInfo)
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            handleRemoteNotification(userInfo)
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    //MARK:添加推送回调方法
    @available(iOS 12.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter?, openSettingsFor notification: UNNotification?) {
        
        let userInfo = notification?.request.content.userInfo
        if (notification?.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            handleRemoteNotification(userInfo)
            JPUSHService.handleRemoteNotification(userInfo)
        }
        
    }
    func handleRemoteNotification(_ userInfo: [AnyHashable : Any]?) {
        //MARK: 处理推送消息
    }
}


