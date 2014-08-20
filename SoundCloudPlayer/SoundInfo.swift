//
//  SoundInfo.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/17/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import UIKit

class SoundInfo {
  var trackId: Int
  var waveformUrl: String?
  var artworkUrl: String?
  var title: String?
  var streamUrl: String?
  var duration: Int?
  
  init(JSON: AnyObject!) {
    trackId = JSON["id"] as Int
    artworkUrl = JSON["artwork_url"] as String!
    waveformUrl = JSON["waveform_url"] as String!
    streamUrl = JSON["stream_url"] as String!
    title = JSON["title"] as String!
    duration = JSON["duration"] as Int!
  }
  
  func downloadWaveformData(completionHandler: (Array<Double>, NSError?) -> Void) -> Void {
    
  }
}
