//
//  JHBaseViewController.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/19.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

open class JHBaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = JHGeneralColor.themeBackColor()
      
        if let index = self.navigationController?.viewControllers.firstIndex(where: {$0.isEqual(self)}){
            if index != 0{
                self.configBackItem()
            }
        }
    }
    fileprivate func configBackItem(){
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "back_normal"), for: UIControl.State.normal)
        button.setImage(UIImage.init(named: "back_highlight"), for: UIControl.State.highlighted)
        button.addTouchUpInsideAction { (button) in
         self.navigationController?.popViewController(animated: true)
        }
        
        let backItem = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = backItem
    }
}
