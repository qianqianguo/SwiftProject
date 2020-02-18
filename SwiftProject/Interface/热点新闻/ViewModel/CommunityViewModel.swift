//
//  CommunityViewModel.swift
//  SwiftProject
//
//  Created by Jivan on 2020/2/10.
//  Copyright © 2020 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import RxSwift

class CommunityViewModel: NSObject {
    
    func getHotNews() -> Observable<HotNewsData> {
        return provider.rx.request(.getHotNews("985363eda62c4f60a3fe2fb9c4b074e6","top"))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .asObservable()
            .mapObject(type: HotNewsData.self)
       }
}

