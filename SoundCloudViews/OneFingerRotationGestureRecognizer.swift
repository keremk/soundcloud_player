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

  override public func touchesBegan(touches: NSSet!, withEvent event: UIEvent) {
    if event.touchesForGestureRecognizer(self).count > 1 {
      state = UIGestureRecognizerState.Failed
    }
  }
  
  override public func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
    if self.state == .Possible {
      state = .Began
    } else {
      state = .Changed
    }
  
    let touch:UITouch = touches.anyObject() as UITouch
    let center = CGPoint(x: view.bounds.midX, y:view.bounds.midY)
    let curTouchPoint = touch.locationInView(view)
    let prevTouchPoint = touch.previousLocationInView(view)
    
    let curCenterDistY = Float(curTouchPoint.y - center.y)
    let curCenterDistX = Float(curTouchPoint.x - center.x)
    let prevCenterDistY = Float(prevTouchPoint.y - center.y)
    let prevCenterDistX = Float(prevTouchPoint.x - center.x)
    
    rotationAngle = atan2f(curCenterDistY, curCenterDistX) - atan2f(prevCenterDistY, prevCenterDistX)
  }

  override public func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
    if state == .Changed {
      state = .Ended
    } else {
      state = .Failed
    }
  }
  
  override public func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
    state = .Failed
  }
}
