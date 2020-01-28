//
//  NewsModel.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/11.
//  Copyright © 2018 Jivan. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsModel: Mappable {
    var top_stories:[top_News]?
    var date:String?
    var stories:[News]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
         top_stories <- map["top_stories"]
         date <- map["date"]
         stories <- map["stories"]
        
    }
    
    
}
class top_News: Mappable {
    
    var ga_prefix:String?
    var id:Int64?
    var image:String?
    var title:String?
    var type:Int64?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        image <- map["image"]
        title <- map["title"]
        type <- map ["type"]
    }
    
    
}
class News: Mappable {
    
    var ga_prefix:String?
    var id:Int64?
    var images:[String]?
    var title:String?
    var type:Int64?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        images <- map["images"]
        title <- map["title"]
        type <- map ["type"]
    }
    
    
}

class Images : Mappable{
    
    var images : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        images <- map["images"]
       
    }
    
    
}
