//
//  UIColor+Utils.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/5.
//  Copyright © 2018 Jivan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    //颜色
    convenience init(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat,_ a: CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
  
    convenience init(_ r: CGFloat,_ g: CGFloat,_ b: CGFloat){
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    /// 根据#16进制字符串返回颜色
    ///
    /// - Parameter HexString: #d81e06 七位字符串
    convenience init(_ HexString: String,alpha:CGFloat){
    
            var red: UInt32 = 0x0
            var green: UInt32 = 0x0
            var blue: UInt32 = 0x0
            let redString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 1)...HexString.index(HexString.startIndex, offsetBy: 2)])
            let greenString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 3)...HexString.index(HexString.startIndex, offsetBy: 4)])
            let blueString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 5)...HexString.index(HexString.startIndex, offsetBy: 6)])
            Scanner(string: redString).scanHexInt32(&red)
            Scanner(string: greenString).scanHexInt32(&green)
            Scanner(string: blueString).scanHexInt32(&blue)
            self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
        
      
        
    }
    
    /// 根据#16进制字符串返回颜色
    ///
    /// - Parameter HexString: #d81e06 七位字符串
    convenience init(_ HexString: String){
        
        var red: UInt32 = 0x0
        var green: UInt32 = 0x0
        var blue: UInt32 = 0x0
        let redString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 1)...HexString.index(HexString.startIndex, offsetBy: 2)])
        let greenString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 3)...HexString.index(HexString.startIndex, offsetBy: 4)])
        let blueString = String(HexString[HexString.index(HexString.startIndex, offsetBy: 5)...HexString.index(HexString.startIndex, offsetBy: 6)])
        Scanner(string: redString).scanHexInt32(&red)
        Scanner(string: greenString).scanHexInt32(&green)
        Scanner(string: blueString).scanHexInt32(&blue)
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha:1.0)

    }
    
  
    
    
}
