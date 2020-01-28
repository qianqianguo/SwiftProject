//
//  MainCollectionViewCell.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/6.
//  Copyright © 2018 Jivan. All rights reserved.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
   
    var imgView:UIImageView!
    var titleLab:UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        imgView = UIImageView()
        addSubview(imgView)
        
        imgView.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalToSuperview().offset(5)
            ConstraintMaker.centerY.equalToSuperview()
            ConstraintMaker.size.equalTo(CGSize(width:self.contentView.height-10, height: self.contentView.height-10))
            
        }
       
        titleLab = UILabel()
        addSubview(titleLab)
        titleLab.numberOfLines = 0
        
        titleLab.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.equalTo(imgView.snp.right).offset(5)
            ConstraintMaker.top.equalToSuperview().offset(5)
            ConstraintMaker.right.equalTo(contentView.snp.right)
            
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


