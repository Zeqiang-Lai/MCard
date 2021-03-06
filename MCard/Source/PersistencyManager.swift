//
//  PersistentManager.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/23.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Foundation

final class PersistencyManager {
    
    enum Constant {
        static let defaultTxtSeperator = " "
    }
    
    private var words = [Word]()
    
    init() {
//        let url = UserSetting.standard.userWordBookUrl
//        if let userURL = url {
//            var data = try? Data(contentsOf: userURL)
//            if data == nil, let bunderURL = Bundle.main.url(forResource: FileNames.WordBook, withExtension: nil) {
//                data = try? Data(contentsOf: bunderURL)
//            }
//
//            if let wordsData = data,
//                let decodedWords = try? JSONDecoder().decode([Word].self, from: wordsData) {
//                words = decodedWords
//                saveWords()
//            }
//        }
        let word1 = Word(first: "apple", second: "苹果", ipa: "")
        let word2 = Word(first: "pear", second: "梨", ipa: "")
        let word3 = Word(first: "important", second: "重要的", ipa: "")
        let word4 = Word(first: "happy", second: "开心的", ipa: "")
        
        words = [word1, word2, word3, word4]
//        saveWords()
    }
    
    func getWords() -> [Word] {
        return words
    }
    
}

extension PersistencyManager {
    func openWordBook(from url: URL) {
        if url.pathExtension == "json" {
            parseJson(from: url)
        } else if url.pathExtension == "txt" {
            parseTxt(from: url)
        } else {
            return
        }
       
    }
    
    func parseTxt(from url: URL) {
        let data = try? String(contentsOf: url)
        if let str = data{
            var lines = str.components(separatedBy: "\n")
            var tempWords = [Word]()
            
            // Determine the seperator
            var lineSeperator = Constant.defaultTxtSeperator
            if let firstLine = lines.first, !firstLine.containsLetters(){
                lineSeperator = firstLine
                lines.removeFirst()
            }
            let priorSeperator = lineSeperator
            
            for line in lines{
                if line == "" { continue }
                
                if line.contains("\t") { lineSeperator = "\t" }
                let items = line.components(separatedBy: lineSeperator)
                lineSeperator = priorSeperator
                
                switch items.count{
                case 1:
                    tempWords.append(Word(first: items[0], second: "", ipa: ""))
                case 2:
                    tempWords.append(Word(first: items[0], second: items[1], ipa: ""))
                case 3:
                    tempWords.append(Word(first: items[0], second: items[1], ipa: items[2]))
                default:
                    continue
                }
            }
            words = tempWords
        }
    }
    
    func parseJson(from url: URL) {
        let data = try? Data(contentsOf: url)
        if let wordsData = data,
            let decodedWords = try? JSONDecoder().decode([Word].self, from: wordsData) {
            words = decodedWords
        }
    }
}

extension PersistencyManager {
    private enum FileNames {
        static let WordBook = "WordBook.json"
    }
    
    private var documents: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveWords() {
        let url = documents.appendingPathComponent(FileNames.WordBook)
        let encoder = JSONEncoder()
        guard let encodedData = try? encoder.encode(words) else {
            return
        }
        try? encodedData.write(to: url)
    }
}
