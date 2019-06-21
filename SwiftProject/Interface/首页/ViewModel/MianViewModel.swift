//
//  MianViewModel.swift
//  SwiftProject
//
//  Created by qmai on 2019/6/21.
//  Copyright © 2019年 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class MianViewModel: NSObject {
    
    func getNews() -> Observable<NewsModel> {
        
        return provider.rx.request(.getNews)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: NewsModel.self)
    }
}
