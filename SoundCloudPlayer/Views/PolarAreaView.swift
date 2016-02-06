//
//  PolarAreaView.swift
//  SoundCloudPlayer
//
//  Created by Kerem Karatal on 8/14/14.
//  Copyright (c) 2014 CodingVentures. All rights reserved.
//

import QuartzCore
import UIKit

@IBDesignable
public class PolarAreaView: UIView {
    public var totalTime: NSTimeInterval = 0
    
    public var timeElapsed: NSTimeInterval {
        get {
            return totalTime * (Double(highlightAngle) / (2*M_PI))
        }
    }
    
    @IBInspectable
    public var innerRadius:CGFloat = 5.0 {
        didSet { updateLayerProperties() }
    }
    
    @IBInspectable
    public var radii: [Double] = [] {
        didSet {
            polarAreaPath = calculatePolarAreaPath()
            maskPath = calculateMaskPath()
            updateLayerProperties()
        }
    }
    
    @IBInspectable
    public var nonHighlightedColor: UIColor = UIColor.lightGrayColor() {
        didSet { updateLayerProperties() }
    }
    
    @IBInspectable
    public var highlightedColor: UIColor = UIColor.orangeColor() {
        didSet { updateLayerProperties() }
    }
    
    @IBInspectable
    public var highlightAngle: CGFloat = 0.0 {
        didSet {
            maskPath = calculateMaskPath()
            updateLayerProperties()
        }
    }
    
    private var polarAreaLayer: CAShapeLayer!
    private var highlightedPolarLayer: CAShapeLayer!
    private var maskLayer: CAShapeLayer!
    
    private var polarAreaPath: UIBezierPath!
    private var maskPath: UIBezierPath!
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if (polarAreaPath == nil) {
            polarAreaPath = calculatePolarAreaPath()
        }
        
        if (maskPath == nil) {
            maskPath = calculateMaskPath()
        }
        
        if (polarAreaLayer == nil) {
            polarAreaLayer = CAShapeLayer()
            layer.addSublayer(polarAreaLayer)
            polarAreaLayer.frame = layer.bounds
            layer.masksToBounds = true
        }
        
        if (highlightedPolarLayer == nil) {
            highlightedPolarLayer = CAShapeLayer()
            layer.addSublayer(highlightedPolarLayer)
            highlightedPolarLayer.frame = layer.bounds
        }
        
        if (maskLayer == nil) {
            maskLayer = CAShapeLayer()
        }
        
        updateLayerProperties()
    }
    
    func updateLayerProperties() {
        if (polarAreaLayer != nil) {
            polarAreaLayer.path = polarAreaPath.CGPath
            polarAreaLayer.fillColor = nonHighlightedColor.CGColor
        }
        
        if (highlightedPolarLayer != nil) {
            highlightedPolarLayer.path = polarAreaPath.CGPath
            highlightedPolarLayer.fillColor = highlightedColor.CGColor
            maskLayer.path = maskPath.CGPath
            highlightedPolarLayer.mask = maskLayer
        }
    }
    
    func calculatePolarAreaPath() -> UIBezierPath {
        return createAllSlices(bounds, cutOffAngle: CGFloat(2.0*M_PI))
    }
    
    func calculateMaskPath() -> UIBezierPath {
        return createSlice(CGFloat(0.0), endAngle: CGFloat(highlightAngle), radius: CGFloat(maxDiameter(bounds) / 2.0), center: centerPoint(bounds))
    }
    
    func maxDiameter(boundsRect: CGRect) -> Double {
        return max(Double(boundsRect.width), Double(boundsRect.height))
    }
    
    func centerPoint(boundsRect: CGRect) -> CGPoint {
        return CGPoint(x: boundsRect.midX, y: boundsRect.midY)
    }
    
    func createAllSlices(boundsRect: CGRect, cutOffAngle: CGFloat) -> UIBezierPath {
        var startAngle: CGFloat = CGFloat(0.0)
        var endAngle: CGFloat
        let sliceAngle: CGFloat = CGFloat(2.0 * M_PI / Double(radii.count))
        let center:CGPoint = centerPoint(boundsRect)
        
        let fullPath = UIBezierPath()
        var shouldBreak = false
        for radius in radii {
            let adjustedRadius = CGFloat(radius * maxDiameter(boundsRect) / 2.0)
            endAngle = startAngle + sliceAngle
            if endAngle > cutOffAngle {
                endAngle = cutOffAngle
                shouldBreak = true
            }
            let translateX = center.x + innerRadius * cos(startAngle + sliceAngle / 2.0)
            let translateY = center.y + innerRadius * sin(startAngle + sliceAngle / 2.0)
            let adjustedCenter = CGPoint(x: translateX, y: translateY)
            
            let slicePath = createSlice(startAngle, endAngle: endAngle, radius: adjustedRadius, center: adjustedCenter)
            
            fullPath.appendPath(slicePath)
            startAngle = endAngle
            if shouldBreak {
                break
            }
        }
        return fullPath
    }
    
    func createSlice(startAngle: CGFloat, endAngle: CGFloat, radius: CGFloat, center:CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        
        path.moveToPoint(center)
        let firstPointX = radius * cos(startAngle) + center.x;
        let firstPointY = radius * sin(startAngle) + center.y;
        path.addLineToPoint(CGPoint(x: firstPointX, y: firstPointY))
        path.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.addLineToPoint(center)
        
        return path
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        radii = [0.32142857142857145,
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