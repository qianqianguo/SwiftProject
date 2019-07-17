//
//  JHBaseTabBarController.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/19.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class JHBaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addChildViewControllers() ;
    }
    //添加子控制器
    func addChildViewControllers() {
        //图片大小建议32*32
        addChildrenViewController(JHMainViewController(), andTitle: "首页", andImageName: "main")
        addChildrenViewController(JHBaseViewController(), andTitle: "社区", andImageName: "community")
        addChildrenViewController(JHBaseViewController(), andTitle: "个人中心", andImageName: "mine")
    }
    func addChildrenViewController(_ childVC: UIViewController?, andTitle title: String?, andImageName imageName: String?) {
        childVC?.tabBarItem.image = (UIImage(named: imageName ?? ""))?.withRenderingMode(.alwaysOriginal)
        // 选中的颜色由tabbar的tintColor决定
        childVC?.tabBarItem.selectedImage = (UIImage(named: "\(imageName ?? "")_sel"))?.withRenderingMode(.alwaysOriginal)
        childVC?.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor:JHGeneralColor.tabBarTitleSelectedColor()
            ], for: .selected)
        childVC?.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor:JHGeneralColor.tabBarTitleNormalColor()
            ], for: .normal)
        childVC?.title = title
        var baseNav: JHBaseNavigationController? = nil
        if let childVC = childVC {
            baseNav = JHBaseNavigationController(rootViewController: childVC)
        }
        if let baseNav = baseNav {
            addChild(baseNav)
        }
    }
}
