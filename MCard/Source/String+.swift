//
//  String+.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/27.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

extension String {
    func containsLetters() -> Bool {
        let letters = CharacterSet.letters
        for ch in self.unicodeScalars {
            if letters.contains(ch) {
                return true
            }
        }
        return false
    }
}
