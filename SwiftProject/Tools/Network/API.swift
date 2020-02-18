//
//  API.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/20.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

enum API {
    case getNews
    case getHotNews(String,String)
}

extension API:TargetType{
    var headers: [String : String]? {
        return [:]
    }
    

    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    
    var baseURL: URL {
        
        switch self {
               case .getNews:
                 return URL(string: "http://news-at.zhihu.com/api")!
        case .getHotNews(_,_):
                return URL(string: "http://api.avatardata.cn/TouTiao/Query")!
        }
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/4/news/latest"
        case .getHotNews(_,_):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        case .getHotNews(_,_):
           return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
            /*
             * 正常请求需要参数时，可写成
             * case .Login(let username,let password):
             *     return ["username": username, "password": password]
             */
        case .getNews:
            return nil
            
        case .getHotNews(let key,let type):
            return ["key":key,"type":type]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getNews:
            return "News successfully".data(using: String.Encoding.utf8)!
        case .getHotNews:
             return "HotNews successfully".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: parameterEncoding)
    }
    
    var validate: Bool {
        return false
    }
}
    let provider = MoyaProvider<API>()



