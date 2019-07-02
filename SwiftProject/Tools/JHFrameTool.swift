//
//  JHFrameTool.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/2.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class JHFrameTool: NSObject {
    
    class func isIphoneX() -> Bool {
        
        var iPhoneXSeries = false
        
        if UIDevice.current.userInterfaceIdiom != .phone {
            return iPhoneXSeries
        }
        
        if #available(iOS 11.0, *) {
            let mainWindow: UIWindow? = UIApplication.shared.delegate?.window ?? nil
            if (mainWindow?.safeAreaInsets.bottom ?? 0.0) > 0.0 {
                iPhoneXSeries = true
            }
        }
        
        return iPhoneXSeries
    }
    
    class func iphoneBottomHeight() -> CGFloat {
        return JHFrameTool.isIphoneX() ? 34.0 : 0.0
    }
    
    class func tabBarHeight() -> CGFloat {
        return self.iphoneBottomHeight() + 49.0
    }
    
    class func statusBarHeight() -> CGFloat {
        return JHFrameTool.isIphoneX() ? 44.0 : 20.0
    }
    
    class func navigationBarHeight() -> CGFloat {
        return 44.0
    }
    
    class func navigationBarAndstatusBarHeight() -> CGFloat {
        return JHFrameTool.statusBarHeight() + JHFrameTool.navigationBarHeight()
    }
    
    class func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    class func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class func screenWidthScale() -> CGFloat {
        return UIScreen.main.bounds.size.width / 375.00
    }
    
    class func screenHeightScale() -> CGFloat {
        return UIScreen.main.bounds.size.height / 667.00
    }
}



