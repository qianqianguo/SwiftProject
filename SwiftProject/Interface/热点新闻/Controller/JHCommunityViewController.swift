//
//  JHCommunityViewController.swift
//  SwiftProject
//
//  Created by Jivan on 2020/2/10.
//  Copyright © 2020 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift
import Kingfisher
import WebKit

class JHCommunityViewController: JHBaseViewController {
   
    let  communityViewModel = CommunityViewModel()
    var hotNewsData:[CommunityNewsModel]?
    fileprivate var layout:MainCollectionViewFlowLayout?
    fileprivate let disposeBag = DisposeBag()
    lazy var  collectionView:UICollectionView = {
          
           layout = MainCollectionViewFlowLayout()
           layout?.itemSize = CGSize(width: JHFrameTool.screenWidth(), height:80)
                  
                  let rect = CGRect(x: 0, y:JHFrameTool.navigationBarAndstatusBarHeight(), width: JHFrameTool.screenWidth(), height:JHFrameTool.screenHeight()-JHFrameTool.navigationBarAndstatusBarHeight()-JHFrameTool.tabBarHeight())
                 let  collectionView = UICollectionView(frame: rect, collectionViewLayout: layout!)
                  collectionView.delegate = self
                  collectionView.dataSource = self
                  collectionView.register(MainCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
                  collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
                  collectionView.backgroundColor = UIColor.groupTableViewBackground
           view.addSubview(collectionView)
        collectionView.mj_header =  MJRefreshNormalHeader.init(refreshingBlock: {
                 
            self.communityViewModel.getHotNews().subscribe(onNext: { (newsData) in
                             
                              self.hotNewsData = newsData.result?.data ;
                              
                          }, onError: { (Error) in
                              
                          }, onCompleted: {
                            //这里刷新UI
                            self.collectionView.mj_header?.endRefreshing()
                               self.collectionView.reloadData()
            }).disposed(by: self.disposeBag)
               })
           return collectionView ;
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communityViewModel.getHotNews().subscribe(onNext: { (newsData) in
           
            self.hotNewsData = newsData.result?.data ;
            
        }, onError: { (Error) in
            
        }, onCompleted: {
          //这里刷新UI
            self.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }
    
}


// MARK: - UICollectionViewDataSource
extension JHCommunityViewController:UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionViewCell
        let news = self.hotNewsData?.safeIndex(i: indexPath.item)
        if news?.title != nil {
            cell.imgView.kf.setImage(with:URL(string:news?.thumbnail_pic_s ?? ""))
            cell.titleLab.text = news?.title
        }
        return cell
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if ((self.hotNewsData?.count) != nil){
            
            return (self.hotNewsData?.count)!
            
        }else{
            
            return 0
        }
        
    }
}

// MARK: - UICollectionViewDelegate
extension JHCommunityViewController:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let news = self.hotNewsData?.safeIndex(i: indexPath.item)
         let url  = NSURL.init(string: news?.url ?? "") as URL?
        if let Url = url {
            let web = BaseBackWebviewController.init(Url, backButtonTitle: "返回", closeButtonTitle: "关闭")
            self.navigationController?.pushViewController(web, animated: true)
        }
        
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension JHCommunityViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    
}






