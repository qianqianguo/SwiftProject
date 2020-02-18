//
//  CommunityNewsModel.swift
//  SwiftProject
//
//  Created by Jivan on 2020/2/10.
//  Copyright © 2020 Anhui YiYun Technologies Co. , Ltd. All rights reserved.
//

import UIKit
import ObjectMapper

class HotNewsData   : Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result <- map["result"]
        reason <- map["reason"]
        error_code <- map["error_code"]
    }
    
    var error_code: Int = 0
    var reason: String!
    var result:Result?
    
}


class Result    : Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        data <- map["data"]
    }
    
    var data: [CommunityNewsModel]?
}


class CommunityNewsModel: Mappable {
    var uniquekey: String?
    var title: String?
    var date: String?
    var category: String?
    var author_name: String?
    var url: String?
    var thumbnail_pic_s: String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        uniquekey <- map["uniquekey"]
        title <- map["title"]
        date <- map["date"]
        category <- map["category"]
        author_name <- map["author_name"]
        url <- map["url"]
        thumbnail_pic_s <- map["thumbnail_pic_s"]
    }
    
  
}



