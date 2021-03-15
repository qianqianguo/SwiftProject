//
//  MBProgressHUD+Utils.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/2.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import Foundation

extension MBProgressHUD{
    // MARK: 显示错误信息
    class func showError(_ error: String?, to view: UIView?) {
        self.show(error, icon: "error", view: view)
    }
    // MARK: 显示成功信息
    class func showSuccess(_ success: String?, to view: UIView?) {
        self.show(success, icon: "success.png", view: view)
    }
    // MARK: 显示加载中
    class func showActivityMessage(_ message:String?){
        self.showActivityMessage(message, view: nil)
    }
    // MARK: 显示错误信息
    class func showError(_ error: String?) {
        self.showError(error, to: nil)
        
    }
    // MARK: 显示成功信息
    class func showSuccess(_ success: String?) {
        self.showSuccess(success, to: nil)
    }
    
    
    
}
extension MBProgressHUD{
    
    // MARK: 显示信息
    class func show(_ text: String?, icon: String?, view: UIView?) {
        var blockView: UIView? = view
        DispatchQueue.main.async(execute: {
            if blockView == nil {
                blockView = UIApplication.shared.windows.last
            }
            // 快速显示一个提示信息
            let hud = MBProgressHUD.showAdded(to: (blockView ?? nil)!, animated: true)
            hud.bezelView.style = MBProgressHUDBackgroundStyle.blur
            hud.label.text = text
            // 设置图片
            hud.customView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/\(icon ?? "")"))
            // 再设置模式
            hud.mode = MBProgressHUDMode.customView
            hud.bezelView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.6)
            hud.contentColor = UIColor.white
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = true
            // 1秒之后再消失
            hud.hide(animated: true, afterDelay: 1.0)
        })
        
    }
    
    
    // MARK: 显示一些信息
    class func showMessage(_ message: String?, to view: UIView?) {
        var blockView: UIView? = view
        DispatchQueue.main.async(execute: {
            if blockView == nil {
                blockView = UIApplication.shared.windows.last
            }
            // 快速显示一个提示信息
            let hud = MBProgressHUD.showAdded(to: (blockView ?? nil)!, animated: true)
            hud.bezelView.style = MBProgressHUDBackgroundStyle.blur
            hud.label.text = message
            hud.mode = MBProgressHUDMode.text
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = true
            hud.bezelView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.6)
            hud.contentColor = UIColor.white
            hud.hide(animated: true, afterDelay: 1.0)
        })
    }
    //MARK: 加载中
    class func showActivityMessage(_ message:String?,view:UIView?){
        var blockView: UIView? = view
        if blockView == nil {
            blockView = UIApplication.shared.windows.last
        }
        let hud = MBProgressHUD.showAdded(to: (blockView ?? nil)!, animated: true)
        hud.bezelView.style = MBProgressHUDBackgroundStyle.blur
        hud.label.text = message
        hud.bezelView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.6)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.contentColor = UIColor.white
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true
    }
    
    class func hideHUDForView(_ view:UIView?){
        var blockView: UIView? = view
        DispatchQueue.main.async(execute: {
            if blockView == nil {
                blockView = UIApplication.shared.windows.last
            }
            self.hide(for:(blockView ?? nil)!, animated: true)
        })
    }
    class func hideHUDForView(){
        self .hideHUDForView(nil);
    }
    
    class func hideHUDForView(_ view:UIView?, animated:Bool){
        var blockView: UIView? = view
        DispatchQueue.main.async(execute: {
            if blockView == nil {
                if #available(iOS 14.0, *) {
                    blockView = UIApplication.shared.windows.first
                }else{
                    blockView = UIApplication.shared.keyWindow
                }
             
            }
            self.hide(for: (blockView ?? nil)!, animated: animated)
        })
    }
}


