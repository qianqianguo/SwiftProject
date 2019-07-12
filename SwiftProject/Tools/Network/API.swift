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
        return URL(string: MyBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/4/news/latest"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNews:
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
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getNews:
            return "Login successfully".data(using: String.Encoding.utf8)!
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
