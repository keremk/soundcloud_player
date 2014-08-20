//
//  SoundCloudClient.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/17/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import Foundation

private let _sharedInstance = SoundCloudClient()

class SoundCloudClient: NSObject {
  private var clientKey:String = ""
  private var clientSecret:String = ""
  private let soundCloudAPIURL:String = "http://api.soundcloud.com/"
  
  class var sharedInstance: SoundCloudClient {
    return _sharedInstance;
  }
  
  override init() {
    super.init()

    if let settings = loadClientSettings() {
      clientKey = settings["clientKey"] as String!
      clientSecret = settings["clientSecret"] as String!
    }
  }
  
  func loadClientSettings() -> Dictionary<String, String>? {
    let filePath:String = NSBundle.mainBundle().pathForResource("secret_keys", ofType: "plist")
    
    // TODO: Error checking needed
    let pListData = NSData(contentsOfFile: filePath)
    let serialized:AnyObject! = NSPropertyListSerialization.propertyListFromData(pListData, mutabilityOption: .Immutable, format: nil, errorDescription: nil)
    
    var settings = serialized as? Dictionary<String, String>
    return settings
  }
  
  func retrieveSoundInfo(soundCloudUrl: String, completionHandler: (SoundInfo?, NSError?) -> Void) -> Self {
    let requestUrl = "https://api.soundcloud.com/resolve.json"
    let params = [ "client_id": clientKey, "url": soundCloudUrl ]
    // "https://api.soundcloud.com/tracks/132726724.json?client_id=\(clientKey)"
    Alamofire.request(.GET, requestUrl, parameters: params, encoding: .URL)
      .responseJSON { (request, response, JSON, error) in
        println(JSON)
        var soundInfo:SoundInfo? = nil
        if error == nil {
          soundInfo = SoundInfo(JSON: JSON)
        }
        completionHandler(soundInfo, error)
    }
    return self
  }
  
  func retrieveArtworkUrl(waveformUrl: String, completionHandler: (Array<Double>?, NSError?) -> Void) -> Self {
    let artworkDataUrl = "http://www.waveformjs.org/w"
    println(artworkDataUrl)
    let params = [ "url": waveformUrl ]
    Alamofire.request(.GET, artworkDataUrl, parameters:params, encoding: .URL)
      .responseJSON { (request, response, JSON, error) in
        println(JSON)
        var results: Array<Double> = JSON as Array<Double>
        completionHandler(results, error)
    }
    return self
  }
}
