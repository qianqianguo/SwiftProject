//
//  Array+Utils.swift
//  BasicFramework
//
//  Created by Jivan on 2018/11/5.
//  Copyright © 2018 Jivan. All rights reserved.
//

import Foundation

extension Array {
    
    /// 安全索引
    ///
    /// - Parameter i: 索引
    /// - Returns: 根据索引返回的Element
    func safeIndex(i: Int) -> Element? {
        return i < self.count && i >= 0 ? self[i] : nil
    }
    
    
}
