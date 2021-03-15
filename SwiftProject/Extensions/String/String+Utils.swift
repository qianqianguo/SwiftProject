//
//  String+Utils.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/5.
//  Copyright © 2018 Jivan. All rights reserved.
//

import Foundation
import UIKit
extension String{
    
    //手机号码验证 MODIFIED BY HELENSONG
    func isValidateMobile() -> Bool {
        /**
         * 手机号码
         * 移动：134,135,136,137,138,139,150,151,152,157,158,159,182,183,187,188
         * 联通：130,131,132,155,156,185,186
         * 电信：133,153,180,189
         */
        let MOBILE = "^((13[0-9])|(14[0-9])|(15[^4,\\D])|(17[0-9])|(18[0,0-9]))\\d{8}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@", MOBILE)
        return regextestmobile.evaluate(with: self)
    }
    
    
    /**
     获取App当前名称
     @return App名称
     */
    static func getAppName() -> String? {
        let infoDictionary = Bundle.main.infoDictionary
        // app名称
        let app_Name = infoDictionary?["CFBundleDisplayName"] as? String
        return app_Name
    }
    /**
     获取App 当前版本号
     @return App 版本号
     */
    static func getAppVersion() -> String? {
        let infoDictionary = Bundle.main.infoDictionary
        // app名称
        let app_Version = infoDictionary?["CFBundleShortVersionString"] as? String
        return app_Version
    }
    
    /// 根据时间段显示不同显示格式
    ///
    /// - Parameters:
    ///   - start: 开始时间
    ///   - end: 结束时间
    /// - Returns: 时间显示方式
    static func stringInterval(from start: Date?, to end: Date?) -> String? {
        var interval = Int((end?.timeIntervalSince1970 ?? 0.0) - (start?.timeIntervalSince1970 ?? 0.0))
        if interval <= 0 {
            return "刚刚"
        }
        if interval < 60 {
            return String(format: "%zd 秒前", interval)
        }
        interval = interval / 60
        if interval < 60 {
            return String(format: "%zd 分钟前", interval)
        }
        interval = interval / 60
        if interval < 24 {
            return String(format: "%zd 小时前", interval)
        }
        interval = interval / 24
        if interval < 7 {
            return String(format: "%zd 天前", interval)
        }
        if interval < 30 {
            return String(format: "%zd 周前", interval / 7)
        }
        if interval < 365 {
            return String(format: "%zd 个月前", interval / 30)
        }
        return String(format: "%zd 年前", interval / 365)
    }
    
    //判断邮箱是否有效
    static func validateEmail(_ email: String?) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
}
    
/** label高度计算 */
func boundingRect(with size: CGSize, withFont font: Int) -> CGSize {
    
    let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(font))]
    let retSize: CGSize = boundingRect(with: size, options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: attribute, context: nil).size
    return retSize
   }
    
}

