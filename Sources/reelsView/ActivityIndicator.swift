//
//  File.swift
//  
//
//  Created by kaushik on 04/08/24.
//

import Foundation
import UIKit

// Activity indicator class to perform loading animations
class ActivityIndicator: UIView {
    
    // Private properties which are used within this class
    private var isAnimating = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(white: 0.0, alpha: 0.7)
    }
    
    // Creating the circle layer of animation
    private func createCircleLayer() -> CALayer {
        let circle = CALayer()
        circle.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        circle.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        circle.cornerRadius = 20
        circle.backgroundColor = UIColor.systemBlue.cgColor
        return circle
    }
    
    // Making the activity indicator to start animating
    open func startAnimating() {
        guard !isAnimating else { return }
        isAnimating = true
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 1
        animation.repeatCount = .infinity
        
        let circle = createCircleLayer()
        self.layer.addSublayer(circle)
        circle.add(animation, forKey: "rotationAnimation")
    }
    
    // Making the activity indicator to stop animating
    open func stopAnimating() {
        guard isAnimating else { return }
        isAnimating = false
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
}
