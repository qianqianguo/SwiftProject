//
//  JHScanLineAnimation.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/3.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class JHScanLineAnimation: UIImageView {

    var isAnimationing = false
    var animationRect: CGRect = CGRect.zero
    
    func startAnimatingWithRect(animationRect: CGRect, parentView: UIView, image: UIImage?)
    { 
        self.image = image
        self.animationRect = animationRect
        parentView.addSubview(self)
        
        self.isHidden = false;
        
        isAnimationing = true;
        
        if image != nil
        {
            stepAnimation()
        }
        
    }
    
    @objc func stepAnimation()
    {
        if (!isAnimationing) {
            return;
        }
        
        var frame:CGRect = animationRect;
        
        let hImg = self.image!.size.height ;
        
         frame.size.height = hImg;
         self.frame = frame;
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 3.0
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = false
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: self.center.y))
        let finalY = animationRect.origin.y
        
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y:animationRect.size.height + finalY))
        self.layer.add(animation, forKey: nil)
    }
    
    func stopStepAnimating()
    {
        self.isHidden = true;
        isAnimationing = false;
    }
    
    static public func instance()->JHScanLineAnimation
    {
        return JHScanLineAnimation()
    }
    
    deinit
    {
        stopStepAnimating()
    }

}





