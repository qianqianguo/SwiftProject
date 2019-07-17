//
//  JHBaseNavigationController.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/19.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class JHBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: JHGeneralColor.navigationBarTitleColor()]

   }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
   
}
