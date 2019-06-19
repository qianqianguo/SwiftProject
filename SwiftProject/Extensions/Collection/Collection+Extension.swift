//
//  Collection+Extension.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/19.
//  Copyright © 2018 Jivan. All rights reserved.
//


import UIKit

extension Collection {
    /// 判断是否有满足条件的元素
    ///
    /// [1, 2, 3, 4, 5].all { $0 > 10 }
    /// false
    func all(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        for item in self {
            let result = try predicate(item)
            if !result {
                return false
            }
        }
        return true
    }
}
