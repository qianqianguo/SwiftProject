//
//  AppDelegateType.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/17.
//  Copyright © 2018 Jivan. All rights reserved.
//

import UIKit

typealias AppDelegateType = UIResponder & UIApplicationDelegate

class CompositeAppDelegate: AppDelegateType{
    
    private let appDelegates: [AppDelegateType]
    
    init(appDelegates: [AppDelegateType]) {
        self.appDelegates = appDelegates
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appDelegates.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        appDelegates.forEach { _ = $0.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken) }
    }
    
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        appDelegates.forEach { _ = $0.applicationDidEnterBackground?(application)
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        appDelegates.forEach { _ = $0.applicationDidBecomeActive?(application)
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        appDelegates.forEach { _ = $0.applicationWillResignActive?(application)
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        appDelegates.forEach { _ = $0.applicationWillEnterForeground?(application)
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        appDelegates.forEach { _ = $0.applicationWillTerminate?(application)
        }
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        appDelegates.forEach { _ = $0.application?(application, performActionFor: shortcutItem, completionHandler: completionHandler) }
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        appDelegates.forEach{_ = $0.application?(app, open: url, options: options)}
        return true
    }
}



