//
//  StringArrayExtension.swift
//  Pandemify
//
//  Created by Anda Tilea on 12.08.2021.
//

import Foundation

extension Collection where Iterator.Element == Int {
    var toStringArray: [String] {
        return compactMap { String($0) }
    }
}

extension Collection where Iterator.Element == Double {
    var toStringArray: [String] {
        return compactMap { String($0) }
    }
}
