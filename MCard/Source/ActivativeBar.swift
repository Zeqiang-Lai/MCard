//
//  ActivativeBar.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/24.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Cocoa

class ActivativeBar: NSView {
    
    override func viewDidMoveToWindow() {
        // init
        let styleMask: NSWindow.StyleMask = [.titled, .fullSizeContentView]
        self.window?.animator().styleMask = styleMask
        self.window?.animator().titleVisibility = NSWindow.TitleVisibility.hidden
        
        self.refreshTrackArea()
    }
    
    var trackingArea: NSTrackingArea?
    
    func refreshTrackArea() {
        if trackingArea != nil {
            self.removeTrackingArea(trackingArea!)
        }
        trackingArea = NSTrackingArea.init(rect: self.bounds, options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeAlways], owner: self, userInfo: nil)
        self.addTrackingArea(trackingArea!)
    }
    
    override func mouseEntered(with event: NSEvent) {
        let styleMask: NSWindow.StyleMask = [.closable, .titled, .resizable, .miniaturizable, .fullSizeContentView]
        self.window?.animator().styleMask = styleMask
//        self.window?.animator().titleVisibility = NSWindow.TitleVisibility.visible
    }
    
    override func mouseExited(with event: NSEvent) {
        let styleMask: NSWindow.StyleMask = [.titled, .fullSizeContentView]
        self.window?.animator().styleMask = styleMask
//        self.window?.animator().titleVisibility = NSWindow.TitleVisibility.hidden
    }
    
}
