//
//  JHPayManager.swift
//  SwiftProject
//
//  Created by qmai on 2019/7/3.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit

class JHPayManager: NSObject,WXApiDelegate {
    
    enum PayCode : Int {
        case wxsuccess = 1001 //*< 成功
        case wxerror = 1002 //*< 失败
        case wxcancel = 1003 //*< 取消
        case wxerror_notinstall = 1004 //*< 未安装微信
        case wxerror_unsupport = 1005 //*< 微信不支持
        case wxerror_params = 1006 //*< 支付参数解析错误
        case alipaysucess = 1101 //*< 支付宝支付成功
        case alipayerror = 1102 //*< 支付宝支付错误
        case alipaycancel = 1103 //*< 支付宝支付取消
    }
    
    static let shared = JHPayManager()
    fileprivate var paySuccess: ((_ code: PayCode) -> Void)?
    fileprivate var payError: ((_ code: PayCode) -> Void)?
    fileprivate var authSuccess: ((_ code: PayCode, _ authCode: String?) -> Void)?
    
    
    ///回调处理
    func handleOpen(_ url: URL?) -> Bool {
        if (url?.host == "safepay") {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback: { resultDic in
                //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
                if let resultDic = resultDic {
                    print("result = \(resultDic)")
                }
                
                let resultCode = ((resultDic?["resultStatus"] as? NSString)?.intValue)
                switch resultCode {
                case 9000 /*支付成功 */:
                    self.paySuccess?(.alipaysucess)
                case 6001 /*支付取消 */:
                    self.paySuccess?(.alipaycancel)
                default:
                    self.paySuccess?(.alipayerror)
                }
            })
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { resultDic in
                if let resultDic = resultDic {
                    print("result = \(resultDic)")
                }
                // 解析 auth code
                let result = resultDic?["result"] as? String
                var authCode: String? = nil
                if (result?.count ?? 0) > 0 {
                    let resultArr = result?.components(separatedBy: "&")
                    for subResult in resultArr ?? [] {
                        
                        if subResult.count > 10 && subResult.hasPrefix("auth_code=") {
                            authCode = (subResult as NSString).substring(from: 10)
                            break
                        }
                    }
                }
                print("授权结果 authCode = \(authCode ?? "")")
            })
            return true
            
        }
        return WXApi.handleOpen(url!, delegate: self)
    }
    
    
}
//MARK: 支付宝支付
extension JHPayManager
{
   public func AliPay(params:String?,success:@escaping(_ code:PayCode) -> Void,failure:@escaping(_ code: PayCode) -> Void){
        self.paySuccess = success ;
        self.payError = failure ;
        //回调地址
        let appScheme =  ""
        AlipaySDK.defaultService()?.payOrder(params,fromScheme: appScheme) { resultDic in
            let resultCode = ((resultDic?["resultStatus"] as? NSString)?.intValue)
            switch resultCode{
            case 9000:
                success(.alipaysucess)
                break
            case 6001:
                failure(.alipaycancel)
                break
            default:
                failure(.alipayerror)
                break
            }
            
        }
    }
    
    
}
//MARK: 微信支付
extension JHPayManager{
    //Mark: 微信支付
   public func WXPay(params:String?,success:@escaping(_ code:PayCode) -> Void,failure:@escaping(_ code: PayCode) -> Void){
        self.paySuccess = success ;
        self.payError = failure ;
        //解析JsonString
        let data = params?.data(using: String.Encoding.utf8)!
        
        do {
            let dic:Dictionary = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! Dictionary<AnyHashable, Any>
            let appid:String? = dic["appid"] as? String
            let partnerid:String? = dic["partnerid"] as? String
            let prepayid:String? = dic["prepayid"] as? String
            let package:String? = dic["package"]as? String
            let noncestr:String? = dic["noncestr"]as? String
            let timestamp:String? = dic["timestamp"]as? String
            let sign:String? = dic["sign"]as? String
            if let AppId = appid {
                WXApi .registerApp(AppId, universalLink: "")
            }
            
            if WXApi.isWXAppInstalled() {
                
            }else{
                failure(.wxerror)
                return ;
            }
            if WXApi.isWXAppSupport() {
                
            }else{
                failure(.wxerror)
                return ;
            }
            let req:PayReq = PayReq()
            req.partnerId = partnerid ?? ""
            req.prepayId = prepayid ?? ""
            req.nonceStr = noncestr ?? ""
            req.timeStamp = UInt32((timestamp! as NSString).intValue)
            req.package = package ?? ""
            req.sign = sign ?? ""
            WXApi.send(req)
            
        } catch {
            failure(.wxerror)
            return ;
        }
    }
    //微信认证
   public func WXLogin(success:@escaping(_ code: PayCode, _ authCode: String?) -> Void,failure:@escaping(_ code: PayCode) -> Void){
        self.authSuccess = success
        self.payError = failure
        if WXApi.isWXAppInstalled() {
            
        }else{
            failure(.wxerror)
            return ;
        }
        if WXApi.isWXAppSupport() {
            
        }else{
            failure(.wxerror)
            return ;
        }
        let req:SendAuthReq = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "login"
        WXApi.send(req)
    }
    
    
    //Mark: 微信处理回调
    func onResp(_ resp: BaseResp) {
        //支付
        if resp .isKind(of: PayResp.self) {
            switch resp.errCode{
            case 0:
                self.paySuccess?(.wxsuccess)
                break
            case -2:
                self.payError?(.wxcancel)
                break
            default:
                self.payError?(.wxerror)
            }
        }
        //微信认证
        if resp .isKind(of: SendAuthResp.self) {
            let authResp = resp as! SendAuthResp
            
            switch resp.errCode{
            case 0:
                self.authSuccess?(.wxsuccess,authResp.code)
                break
            case -2:
                self.payError?(.wxcancel)
                break
            default:
                self.payError?(.wxerror)
            }
        }
        
    }
}


