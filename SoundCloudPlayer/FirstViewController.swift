//
//  FirstViewController.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/9/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import UIKit
import SoundCloudViews

class FirstViewController: UIViewController {
                            
  @IBOutlet weak var waveformView: WaveformView!
  @IBOutlet weak var timeLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    var gestureRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
    waveformView.userInteractionEnabled = true
    waveformView.addGestureRecognizer(gestureRecognizer)
  }
  
  override func viewWillAppear(animated: Bool) {
    waveformView.totalTime = 5400
    waveformView.amplitudes = [0.32142857142857145,
      0.8285714285714286,
      0.8571428571428571,
      0.7714285714285715,
      0.2,
      0.6642857142857143,
      0.7,
      0.7571428571428571,
      0.8642857142857143,
      0.8285714285714286,
      0.9,
      0.8214285714285714,
      0.7285714285714285,
      0.6714285714285714,
      0.6642857142857143,
      0.7142857142857143,
      0.8142857142857143,
      0.8714285714285714,
      0.8571428571428571,
      0.8642857142857143,
      0.7857142857142857,
      0.6928571428571428,
      0.6714285714285714,
      0.8785714285714286,
      0.7928571428571428,
      0.7,
      0.6642857142857143,
      0.6857142857142857,
      0.7428571428571429,
      0.8428571428571429,
      0.85,
      0.9,
      0.8428571428571429,
      0.7428571428571429,
      0.6785714285714286,
      0.6571428571428571,
      0.7071428571428572,
      0.7928571428571428,
      0.8785714285714286,
      0.8571428571428571,
      0.8428571428571429,
      0.7642857142857142,
      0.6642857142857143,
      0.6071428571428571,
      0.5857142857142857,
      0.5214285714285715,
      0.6142857142857143,
      0.6714285714285714,
      0.8642857142857143,
      0.8071428571428572,
      0.7071428571428572,
      0.6571428571428571,
      0.5857142857142857,
      0.55,
      0.5642857142857143,
      0.6071428571428571,
      0.8142857142857143,
      0.8857142857142857,
      0.8,
      0.7071428571428572,
      0.6714285714285714,
      0.6785714285714286,
      0.7357142857142858,
      0.8428571428571429,
      0.8571428571428571,
      0.8785714285714286,
      0.8428571428571429,
      0.7571428571428571,
      0.6857142857142857,
      0.6571428571428571,
      0.7]
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func handlePanGesture(sender: UIPanGestureRecognizer!) {
    var translation = sender.translationInView(self.view)
    
    waveformView.currentPlayHead += translation.x
    timeLabel.text = waveformView.timeElapsed.formatAsTimeString()
  }
  
}

