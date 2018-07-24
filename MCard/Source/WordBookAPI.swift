//
//  WordBookAPI.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/23.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

final class WordBookAPI {
    static let shared = WordBookAPI()
    
    private let persistencyManager = PersistencyManager()
    
    private init() {}
    
    func getWords() -> [Word] {
        return persistencyManager.getWords()
    }
    
    func openWordBook(from url: URL) {
        persistencyManager.openWordBook(from: url)
    }
}
