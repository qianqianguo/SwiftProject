//
//  MainCollectionViewFlowLayout.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/6.
//  Copyright © 2018 Jivan. All rights reserved.
//

import UIKit
//首页滑动视图
class MainCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        
        super.prepare()
        scrollDirection = .vertical
        minimumLineSpacing = 0.75
        minimumInteritemSpacing = 0.0
        
    }
    
}
