//
//  NSView+Animation.swift
//  MCard
//
//  Created by Zeqiang on 2018/7/26.
//  Copyright © 2018年 Zeqiang. All rights reserved.
//

import Cocoa

extension NSView {
    
    func horizontalTransitionAnimation(direction: String, duration: TimeInterval = 0.3) {
        // Create a CATransition object
        let transitionAnimation = CATransition()
        
        transitionAnimation.type = kCATransitionPush
        transitionAnimation.subtype = direction
        transitionAnimation.duration = duration
        transitionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        transitionAnimation.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer?.add(transitionAnimation, forKey: "horizontalTransition")
    }
}
