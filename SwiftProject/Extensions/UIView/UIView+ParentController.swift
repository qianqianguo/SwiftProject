//
//  UIView+ParentController.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/8.
//  Copyright © 2018 Jivan. All rights reserved.
//

import Foundation
import UIKit


/* 递归找最上面的viewController */
extension NSObject{
    
    ///获取当前显示的控制器 UIWindow (Visible)
    func getCurrentVC() -> UIViewController {
        let keywindow = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController//UIApplication.shared.keyWindow
        let rootVC = keywindow!//UIApplication.shared.keyWindow!.rootViewController!
        return getVisibleViewControllerFrom(vc: rootVC)
    }
    
    //方法1
    func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UINavigationController).visibleViewController!)
        } else if vc.isKind(of: UITabBarController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UITabBarController).selectedViewController!)
        } else {
            if (vc.presentedViewController != nil) {
                return getVisibleViewControllerFrom(vc: vc.presentedViewController!)
            } else {
                return vc
            }
        }
        
    }
    
    //方法2
    func topViewControllerWithRootViewController(rootVC: UIViewController) -> UIViewController {
        
        if rootVC.isKind(of: UITabBarController.self) {
            let tabVC = rootVC as! UITabBarController
            return topViewControllerWithRootViewController(rootVC: tabVC.selectedViewController!)
        } else if rootVC.isKind(of: UINavigationController.self) {
            let navc = rootVC as! UINavigationController
            return topViewControllerWithRootViewController(rootVC: navc.visibleViewController!)
        } else if (rootVC.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootVC: rootVC.presentedViewController!)
        } else {
            return rootVC
        }
        
    }
    
    ///验证
    func vcResult2(classType: UIViewController.Type) -> Bool {
        return getCurrentVC().isKind(of: classType)
    }

}
