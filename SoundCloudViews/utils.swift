//
//  utils.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/14/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import Foundation

public extension NSTimeInterval {
  func formatAsTimeString() -> String {
    var residue:NSTimeInterval
    let hours = Int(self / 3600)
    residue = self % 3600
    let minutes = Int(residue / 60)
    residue = residue % 60
    let seconds = Int(residue)
    
    var extraMinuteZero = ""
    if minutes < 10 {
      extraMinuteZero = "0"
    }
    var extraSecondZero = ""
    if seconds < 10 {
      extraSecondZero = "0"
    }
    
    let timeInterval = "\(hours):\(extraMinuteZero)\(minutes):\(extraSecondZero)\(seconds)"
    
    return timeInterval
  }
}
