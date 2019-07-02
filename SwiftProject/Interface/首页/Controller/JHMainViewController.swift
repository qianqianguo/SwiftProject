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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        MBProgressHUD.showActivityMessage("加载中...")
        viewModel.getNews().subscribe(onNext: { (newsModel) in
            self.news = newsModel ;
          
        }, onError: { (error) in
             MBProgressHUD.hideHUDForView()
             print(error)
        }, onCompleted: {
            MBProgressHUD.hideHUDForView()
           self.collectionView?.reloadData()
        })
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
            MBProgressHUD.showActivityMessage("加载中...")
            self.viewModel.getNews().subscribe(onNext: { (newsModel) in
                self.collectionView?.mj_header.endRefreshing()
                self.news = newsModel ;
                
            }, onError: { (error) in
                MBProgressHUD.hideHUDForView()
                print(error)
            }, onCompleted: {
                MBProgressHUD.hideHUDForView()
                self.collectionView?.reloadData()
            })
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
        //注册Peek & Pop功能
        registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: cell)
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
// MARK: - UIViewControllerPreviewingDelegate
extension JHMainViewController:UIViewControllerPreviewingDelegate{
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        //1. 获取按压的cell所在的行
        guard let cell = previewingContext.sourceView as? UICollectionViewCell else { return UIViewController() }
        
        let indexPath = collectionView?.indexPath(for: cell)
        
        
        
        //2. 设定预览界面
        //        let vc = BaseBackWebviewController.init(news?.body ?? "")
        let  vc = JHMainViewController.init()
        // 预览区域大小(可不设置), 0为默认尺寸
        //        vc.preferredContentSize = CGSize(width: 0, height: 0)
        
        //调整不被虚化的范围，按压的那个cell不被虚化（轻轻按压时周边会被虚化，再少用力展示预览，再加力跳页至设定界面）
        let rect = CGRect(x: 0, y: 0, width:  JHFrameTool.screenWidth(), height: 80)
        //设置触发操作的视图的不被虚化的区域
        previewingContext.sourceRect = rect
        
        //返回预览界面
        return vc
    }
    
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        viewControllerToCommit.hidesBottomBarWhenPushed = true
        show(viewControllerToCommit, sender: self)
    }
    
}
