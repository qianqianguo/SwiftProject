//
//  JHMainViewController.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/20.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift
import Kingfisher

class JHMainViewController: JHBaseViewController {
    let viewModel = MianViewModel()
    private var collectionView:UICollectionView?
    private var layout:MainCollectionViewFlowLayout?
    private var news:NewsModel?
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.setupUI()
        
        viewModel.getNews().subscribe(onNext: { (newsModel) in
            
            self.news = newsModel ;
          
        }, onError: { (error) in
           
             print(error)
        }, onCompleted: {
            self.collectionView?.reloadData()
            }).disposed(by: disposeBag)
        
    }
    
    private func setupUI(){
        
        self.title = "首页"
        
        layout = MainCollectionViewFlowLayout()
        layout?.itemSize = CGSize(width: JHFrameTool.screenWidth(), height:80)
        
        let rect = CGRect(x: 0, y:JHFrameTool.navigationBarAndstatusBarHeight(), width: JHFrameTool.screenWidth(), height:JHFrameTool.screenHeight()-JHFrameTool.navigationBarAndstatusBarHeight()-JHFrameTool.tabBarHeight())
        collectionView = UICollectionView(frame: rect, collectionViewLayout: layout!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(MainCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(collectionView!)
        collectionView?.mj_header =  MJRefreshNormalHeader.init(refreshingBlock: {
          
            self.viewModel.getNews().subscribe(onNext: { (newsModel) in
                self.collectionView?.mj_header?.endRefreshing()
                self.news = newsModel ;
            }, onError: { (error) in
                print(error)
            }, onCompleted: {
                self.collectionView?.reloadData()
            }).disposed(by: self.disposeBag)
        })
       

        
    }

}

// MARK: - UICollectionViewDataSource
extension JHMainViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        let news = self.news?.stories?.safeIndex(i: indexPath.item)
        if news?.title != nil {
            cell.imgView.kf.setImage(with:URL(string:news?.images?.safeIndex(i: 0) ?? ""))
            cell.titleLab.text = news?.title
        }
        return cell
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if ((self.news?.stories?.count) != nil){
            
            return (self.news?.stories?.count)!
            
        }else{
            
            return 0
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension JHMainViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension JHMainViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    
}

