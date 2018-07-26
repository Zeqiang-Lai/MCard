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
    
    @IBOutlet weak var gestureView: GestureView!
    
    @IBOutlet weak var firstLabelYconstraint: NSLayoutConstraint!
    
    
    private var currentWordIndex = 0
    private var allWords = [Word]()
    
    private var isDarkMode = true
    
    override func viewWillAppear() {
        view.window?.appearance = NSAppearance(named: .vibrantDark)
        view.window?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureView.delegate = self
        
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
        
        // TODO: 这个constant值可以用计算的
        firstLabelYconstraint.animator().constant = -25
        if secondLangLabel.stringValue == "" {
            firstLabelYconstraint.animator().constant = -15
        }
    }
    
    // MARK: Appearance
    
    @IBAction func toggleDarkMode(_ sender: AnyObject) {
        let menu = sender as! NSMenuItem
        menu.state = menu.state == .on ? .off : .on
        
        isDarkMode = !isDarkMode
        view.window?.appearance = isDarkMode ?
            NSAppearance(named: .vibrantDark) : NSAppearance(named: .vibrantLight)
    }
    
    // MARK: Keyboard Control
    
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
    
    // MARK: Open File Dialog
    
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

// MARK: Two finger Swipe Gesture Handler

extension ViewController: GestureViewEventHandler {
    func twoFingerSwipe(deltaX: CGFloat) {
        if deltaX > 0.5 {
            // previous word
            if previousWordIndex() == currentWordIndex {return}
            firstLangLabel.horizontalTransitionAnimation(direction: kCATransitionFromLeft)
            secondLangLabel.horizontalTransitionAnimation(direction: kCATransitionFromLeft)
            ipaLabel.horizontalTransitionAnimation(direction: kCATransitionFromLeft)
            currentWordIndex = previousWordIndex()
            showWord(for: currentWordIndex)
        } else if deltaX < -0.5 {
            // next word
            if nextWordIndex() == currentWordIndex {return}
            firstLangLabel.horizontalTransitionAnimation(direction: kCATransitionFromRight)
            secondLangLabel.horizontalTransitionAnimation(direction: kCATransitionFromRight)
            ipaLabel.horizontalTransitionAnimation(direction: kCATransitionFromRight)
            currentWordIndex = nextWordIndex()
            showWord(for: currentWordIndex)
        }
    }
    
    
}

extension ViewController {
    enum Constant {
        static let oneLabelConstraintMultiplier = 0.84
        static let twoLabelConstraintMultiplier = 0.95
    }
}

extension ViewController: NSWindowDelegate {
    
    func windowDidResize(_ notification: Notification) {
        activativeBar.refreshTrackArea()
    }
}
