//
//  JHScanViewController.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/3.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

public protocol JHScanViewControllerDelegate: class {
     func scanFinished(scanResult: JHScanResult, error: String?)
}

public protocol QRRectDelegate {
    func drawwed()
}

open class JHScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
 //返回扫码结果，也可以通过继承本控制器，改写该handleCodeResult方法即可
   open weak var scanResultDelegate: JHScanViewControllerDelegate?
    
    open var delegate: QRRectDelegate?
    
   open var scanObj: JHScanWrapper?
    
   open var scanStyle: JHScanViewStyle? = JHScanViewStyle()
    
   open var qRScanView: JHScanView?

    
    //启动区域识别功能
   open var isOpenInterestRect = false
    
    //识别码的类型
   public var arrayCodeType:[AVMetadataObject.ObjectType]?
    
    //是否需要识别后的当前图像
   public  var isNeedCodeImage = false
    
    //相机启动提示文字
    public var readyString:String! = "loading"

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
              // [self.view addSubview:_qRScanView];
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    
    open func setNeedCodeImage(needCodeImg:Bool)
    {
        isNeedCodeImage = needCodeImg;
    }
    //设置框内识别
    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
 
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawScanView()
        
        perform(#selector(JHScanViewController.startScan), with: nil, afterDelay: 0.3)
    }
    
    @objc open func startScan()
    {
   
        if (scanObj == nil)
        {
            var cropRect = CGRect.zero
            if isOpenInterestRect
            {
                cropRect = JHScanView.getScanRectWithPreView(preView: self.view, style:scanStyle! )
            }
            
            //指定识别几种码
            if arrayCodeType == nil
            {
                arrayCodeType = [AVMetadataObject.ObjectType.qr as NSString ,AVMetadataObject.ObjectType.ean13 as NSString ,AVMetadataObject.ObjectType.code128 as NSString] as [AVMetadataObject.ObjectType]
            }
            
            scanObj = JHScanWrapper(videoPreView: self.view,objType:arrayCodeType!, isCaptureImg: isNeedCodeImage,cropRect:cropRect, success: { [weak self] (arrayResult) -> Void in
                
                if let strongSelf = self
                {
                    //停止扫描动画
                    strongSelf.qRScanView?.stopScanAnimation()
                    
                    strongSelf.handleCodeResult(arrayResult: arrayResult)
                }
             })
        }
        
        //结束相机等待提示
        qRScanView?.deviceStopReadying()
        
        //开始扫描动画
        qRScanView?.startScanAnimation()
        
        //相机运行
        scanObj?.start()
    }
    
    open func drawScanView()
    {
        if qRScanView == nil
        {
            qRScanView = JHScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
            delegate?.drawwed()
        }
        qRScanView?.deviceStartReadying(readyStr: readyString)
        
    }
   
    
    /**
     处理扫码结果，如果是继承本控制器的，可以重写该方法,作出相应地处理，或者设置delegate作出相应处理
     */
    open func handleCodeResult(arrayResult:[JHScanResult])
    {
        if let delegate = scanResultDelegate  {
            
            self.navigationController? .popViewController(animated: true)
            let result:JHScanResult = arrayResult[0]
            
            delegate.scanFinished(scanResult: result, error: nil)

        }else{
            
            for result:JHScanResult in arrayResult
            {
                print("%@",result.strScanned ?? "")
            }
            
            let result:JHScanResult = arrayResult[0]
            
            showMsg(title: result.strBarCodeType, message: result.strScanned)
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        qRScanView?.stopScanAnimation()
        
        scanObj?.stop()
    }
    
    open func openPhotoAJHum()
    {
        JHPermissions.authorizePhotoWith { [weak self] (granted) in
            
            let picker = UIImagePickerController()
            
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            picker.delegate = self;
            
            picker.allowsEditing = true
            
           self?.present(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        var image:UIImage? = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
        
        if (image == nil )
        {
            image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
        
        if(image != nil)
        {
            let arrayResult = JHScanWrapper.recognizeQRImage(image: image!)
            if arrayResult.count > 0
            {
                handleCodeResult(arrayResult: arrayResult)
                return
            }
        }
      
        showMsg(title: nil, message: NSLocalizedString("Identify failed", comment: "Identify failed"))
    }
    
    func showMsg(title:String?,message:String?)
    {
        
        let alertController = UIAlertController(title: nil, message:message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default) { (alertAction) in
                
//                if let strongSelf = self
//                {
//                    strongSelf.startScan()
//                }
            }
        
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
    }
    deinit
    {
//        print("JHScanViewController deinit")
    }
}
