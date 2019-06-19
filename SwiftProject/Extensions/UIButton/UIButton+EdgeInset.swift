//
//  Category.swift

//
//  Created by Jivan on 16/7/22.
//  Copyright © 2016年 Jivan. All rights reserved.
//
//这个创建的swift  file专门用来写扩展的
import Foundation
import UIKit

//MARK: ------扩展button
extension UIButton {
 
    enum HHButtonEdgeInsetsStyle: Int {
        case top = 1 //image在上，lebel在下
        case left    //image在左，lebel在右
        case bottom  //image在下，lebel在上
        case right   //image在右，lebel在左
    }
    
    func layoutButtonWithEdgesInsetsStyleWithSpace(_ style : HHButtonEdgeInsetsStyle, space : CGFloat) {
        //首先得到imageView和titleLabel的宽高
        let imageWith = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        var labelWith : CGFloat = 0
        var labelHeight : CGFloat = 0
       
       if #available(iOS 8.0, *){
       //由于ios8中titleLabel的size是0，用下面的这种设置
            labelWith = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else{
            labelWith = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space / 2, left: 0, bottom: 0, right: -labelWith)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith!, bottom: -imageHeight! - space / 2, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space / 2, right: -labelWith)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight! - space / 2, left: -imageWith!, bottom: 0, right: 0)
        default:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWith + space / 2, bottom: 0, right: -labelWith - space / 2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith! - space / 2, bottom: 0, right: imageWith! + space / 2)
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}



