//
//  ViewController.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/23.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var ipaLabel: NSTextField!
    @IBOutlet weak var firstLangLabel: NSTextField!
    @IBOutlet weak var secondLangLabel: NSTextField!
    @IBOutlet weak var activativeBar: ActivativeBar!
    
    private var currentWordIndex = 0
    private var allWords = [Word]()
    
    private var isDarkMode = true
    
    override func viewWillAppear() {
        view.window?.appearance = NSAppearance(named: .vibrantDark)
        view.window?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allWords = WordBookAPI.shared.getWords()
        showWord(for: currentWordIndex)
    }

    func showWord(for wordIndex: Int) {
        if wordIndex < 0 || wordIndex >= allWords.count {
            return
        }
        
        ipaLabel.stringValue = allWords[wordIndex].ipa
        firstLangLabel.stringValue = allWords[wordIndex].first
        secondLangLabel.stringValue = allWords[wordIndex].second
    }
    
    // MARK: Appearance
    
    @IBAction func toggleDarkMode(_ sender: AnyObject) {
        let menu = sender as! NSMenuItem
        menu.state = menu.state == .on ? .off : .on
        
        isDarkMode = !isDarkMode
        view.window?.appearance = isDarkMode ?
            NSAppearance(named: .vibrantDark) : NSAppearance(named: .vibrantLight)
    }
    
    // MARK: Control
    
    @IBAction func nextWord(_ sender:AnyObject) {
        currentWordIndex = nextWordIndex()
        showWord(for: currentWordIndex)
    }
    
    @IBAction func previousWord(_ sender:AnyObject) {
        currentWordIndex = previousWordIndex()
        showWord(for: currentWordIndex)
    }
    
    func nextWordIndex() -> Int{
        return currentWordIndex == allWords.count-1 ? currentWordIndex : currentWordIndex + 1
    }
    
    func previousWordIndex() -> Int{
        return currentWordIndex == 0 ? currentWordIndex : currentWordIndex - 1
    }
    
    // MARK: Open Book Source
    
    @IBAction func openWordBook(_ sender: AnyObject) {
        let dialog = NSOpenPanel()
        dialog.title = "Choose the WordBook File"
        dialog.canChooseFiles = true
        dialog.canChooseDirectories = false
        dialog.allowsMultipleSelection = false
        dialog.allowedFileTypes = ["json", "txt"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            if let url = dialog.url {
                WordBookAPI.shared.openWordBook(from: url)
                allWords = WordBookAPI.shared.getWords()
                currentWordIndex = 0
                showWord(for: currentWordIndex)
            }
        } else {
            return
        }
    }
}

extension ViewController: NSWindowDelegate {
    
    func windowDidResize(_ notification: Notification) {
        activativeBar.refreshTrackArea()
    }
}
