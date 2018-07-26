//
//  GestureView.swift
//  GestureTest
//
//  Created by Zeqiang on 2018/7/26.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Cocoa

protocol GestureViewEventHandler {
    func twoFingerSwipe(deltaX: CGFloat)
}

class GestureView: NSView {

    var delegate: GestureViewEventHandler?
    
    override func wantsScrollEventsForSwipeTracking(on axis: NSEvent.GestureAxis) -> Bool {
        return axis == .horizontal
    }

    override func scrollWheel(with event: NSEvent) {
        // Not a gesture scroll event.
        if event.subtype == NSEvent.EventSubtype.mouseEvent { return }
        // Not horizontal
        if abs(event.scrollingDeltaX) <= abs(event.scrollingDeltaY) { return }
        
        var animationCancelled = false
        event.trackSwipeEvent(
            options: .lockDirection,
            dampenAmountThresholdMin: 0,
            max: 0) { (gestureAmount, phase, complete, stop) in
                if animationCancelled {
                    stop.initialize(to: true)
                }
                if (phase == .began) { }
                else if (phase == .ended || phase == .cancelled) {
                    self.delegate?.twoFingerSwipe(deltaX: event.scrollingDeltaX)
                    animationCancelled = true
                }
        }
    }
}
