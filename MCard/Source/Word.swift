//
//  Word.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/23.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

struct Word: Codable {
    let first: String
    let second: String
    // International Phonetic Alphabet
    let ipa: String
}

extension Word: CustomDebugStringConvertible {
    var debugDescription: String {
        return "First: \(self.first)" +
        " Second: \(self.second)" +
        " IPA: \(self.ipa)"
    }
}
