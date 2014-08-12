//
//  WaveformView.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/10/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import QuartzCore
import UIKit

@IBDesignable
class WaveformView: UIView {
  var containerWaveformLayer: CAShapeLayer!
  var topWaveformLayer: CAShapeLayer!
  var bottomWaveformLayer: CAShapeLayer!
  var topTintLayer: CAShapeLayer!
  var amplitudes: [Double] = []
  private var waveformLength:CGFloat = 0.0
  private var currentTranslateX:CGFloat = 0.0

  @IBInspectable
  var topTintColor:UIColor = UIColor.redColor() {
    didSet { updateLayerProperties() }
  }
  
  @IBInspectable
  var percentagePlayed: Double = 0.0 {
    didSet { updateLayerProperties() }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    if !containerWaveformLayer {
      containerWaveformLayer = CAShapeLayer()
      layer.addSublayer(containerWaveformLayer)
    }
    
    if !topWaveformLayer {
      topWaveformLayer = CAShapeLayer()
      containerWaveformLayer.addSublayer(topWaveformLayer)
      
      let startPoint = CGPoint(x: 0.0, y: layer.bounds.height / 2.0)
      let path = createGraph(startPoint, maxAmplitude: -60.0)
      topWaveformLayer.path = path.CGPath
      topWaveformLayer.fillColor = UIColor.grayColor().CGColor
    }

    if !bottomWaveformLayer {
      bottomWaveformLayer = CAShapeLayer()
      containerWaveformLayer.addSublayer(bottomWaveformLayer);
      
      let startPoint = CGPoint(x: 0.0, y: layer.bounds.height / 2.0)
      let path = createGraph(startPoint, maxAmplitude: 30.0)
      bottomWaveformLayer.path = path.CGPath
      bottomWaveformLayer.fillColor = UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0).CGColor
    }

    if (!topTintLayer) {
      topTintLayer = CAShapeLayer()
      containerWaveformLayer.addSublayer(topTintLayer)

      let startPoint = CGPoint(x: 0.0, y: layer.bounds.height / 2.0)
      let path = createGraph(startPoint, maxAmplitude: -60.0)
      topTintLayer.path = path.CGPath
      topTintLayer.fillColor = topTintColor.CGColor
      topTintLayer.masksToBounds = true
    }
    
    containerWaveformLayer.frame = layer.bounds
    topWaveformLayer.frame = containerWaveformLayer.bounds;
    bottomWaveformLayer.frame = containerWaveformLayer.bounds;
    updateLayerProperties()
  }
  
  func updateLayerProperties() {
    currentTranslateX = waveformLength * CGFloat(percentagePlayed)
    if topTintLayer {
      let newFrame = CGRect(x: 0.0, y: 0.0, width: currentTranslateX, height: containerWaveformLayer.bounds.height)
      topTintLayer.frame = newFrame
      topTintLayer.fillColor = topTintColor.CGColor
    }
    if (containerWaveformLayer) {
      let midPoint:CGFloat = layer.bounds.width / 2.0
      containerWaveformLayer.transform = CATransform3DMakeTranslation(midPoint - currentTranslateX, 0.0, 0.0)
    }
  }
  
  func createGraph(startPoint: CGPoint, maxAmplitude: CGFloat) -> UIBezierPath {
    var path = UIBezierPath()
    let midY:CGFloat = startPoint.y
    var x:CGFloat = startPoint.x
    for amplitude in amplitudes {
      let height = CGFloat(amplitude) * maxAmplitude
      let rect = CGRect(x: x, y: midY, width: 10.0, height: height)
      x = x + 12.0
      let subPath = UIBezierPath(rect: rect)
      path.appendPath(subPath)
    }
    waveformLength = x
    return path
  }
  
  func projectPath() -> String? {
    let projectSourceDir = NSProcessInfo.processInfo().environment["IB_PROJECT_SOURCE_DIRECTORIES"]! as String
    let projectPaths = projectSourceDir.componentsSeparatedByString(",")
    
    var projectPath:String?
    if (projectPaths.count > 0) {
      projectPath = projectPaths[0]
    }
    
    return projectPath
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()

    var path = projectPath();
    
    amplitudes = [0.32142857142857145,
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
  
}
