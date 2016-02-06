//
//  OneFingerRotationGestureRecognizer.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/17/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

public class OneFingerRotationGestureRecognizer: UIGestureRecognizer {
    public var rotationAngle:Float = 0.0
    
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        if event.touchesForGestureRecognizer(self)!.count > 1 {
            state = UIGestureRecognizerState.Failed
        }
    }
    
    public override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        if self.state == .Possible {
            state = .Began
        } else {
            state = .Changed
        }
        
        let touch:UITouch = touches.first! as UITouch
        let center = CGPoint(x: view!.bounds.midX, y:view!.bounds.midY)
        let curTouchPoint = touch.locationInView(view)
        let prevTouchPoint = touch.previousLocationInView(view)
        
        let curCenterDistY = Float(curTouchPoint.y - center.y)
        let curCenterDistX = Float(curTouchPoint.x - center.x)
        let prevCenterDistY = Float(prevTouchPoint.y - center.y)
        let prevCenterDistX = Float(prevTouchPoint.x - center.x)
        
        rotationAngle = atan2f(curCenterDistY, curCenterDistX) - atan2f(prevCenterDistY, prevCenterDistX)
    }
    
    public override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        if state == .Changed {
            state = .Ended
        } else {
            state = .Failed
        }
    }
    
    public override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        state = .Failed
    }
}
