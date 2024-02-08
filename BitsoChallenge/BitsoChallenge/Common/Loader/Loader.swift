//
//  Loader.swift
//  BitsoChallenge
//
//  Created by Fede Flores on 06/02/2024.
//

import UIKit

fileprivate enum Constant {
    static let alpha: CGFloat = 0.9
    static let progressViewHeight: CGFloat = 60
    static let progressViewWidth: CGFloat = 60
    static let progressViewMargin: CGFloat = 30
    
    static let inAnimationFromValue: CGFloat = 0.0
    static let inAnimationToValue: CGFloat = 1.0
    static let inAnimationDuration: CGFloat = 1.0
    
    static let outAnimationBeginTime: CGFloat = 0.5
    static let outAnimationFromValue: CGFloat = 0.0
    static let outAnimationToValue: CGFloat = 1.0
    static let outAnimationDuration: CGFloat = 1.0
    
    static let rotationAnimationFromValue: CGFloat = 0.0
    static let rotationAnimationToValue: CGFloat = 2 * Double.pi
    static let rotationAnimationDuration: CGFloat = 2.0
    
    static let circularLayerLineWith: CGFloat = 4.0
    static let inAnimationKeyPath: String = "strokeEnd"
    static let outAnimationKeyPath: String = "strokeStart"
    static let rotationAnimationKeyPath: String = "transform.rotation.z"
    static let circularLayerRotateAnimationKey: String = "rotateAnimation"
    static let circularLayerStrokeAnimationKey: String = "strokeAnimation"
    
}

public class Loader: UIView {
    
    private var progressView: CustomProgressView?
    static var sharedLoader: Loader = Loader()
    var frontWindow: UIWindow?
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            frontWindow = sceneDelegate.window
        }
        customizeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func customizeUI() {
        backgroundColor = .clear
        backgroundColor = .white
        alpha = Constant.alpha
        progressView  = CustomProgressView(frame: CGRect(x: (frame.width/2) - Constant.progressViewMargin, y: (frame.height/2) - Constant.progressViewMargin, width: Constant.progressViewWidth, height: Constant.progressViewHeight))
        if let progressView = progressView {
            addSubview(progressView)
        }
        
    }
    
     func show() {
        startProgresLoader()
    }
}

extension Loader: CAAnimationDelegate {
    
    func start() {
        startProgresLoader()
    }
    
     func hide() {
         progressView?.stopAnimation()
        isHidden = true
        self.removeFromSuperview()
    }

    func startProgresLoader() {
        isHidden = false
        frontWindow?.endEditing(true)
        frontWindow?.addSubview(self)
        progressView?.startAnimation(withColor: UIColor.blue.cgColor)
    }
}


class CustomProgressView: UIView, CAAnimationDelegate {
    
    let circularLayer = CAShapeLayer()
    let strokeAnimationGroup = CAAnimationGroup()
    
    let inAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: Constant.inAnimationKeyPath)
        animation.fromValue = Constant.inAnimationFromValue
        animation.toValue = Constant.inAnimationToValue
        animation.duration = Constant.inAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        
        return animation
    }()
    
    let outAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: Constant.outAnimationKeyPath)
        animation.beginTime = Constant.outAnimationBeginTime
        animation.fromValue = Constant.outAnimationFromValue
        animation.toValue = Constant.outAnimationToValue
        animation.duration = Constant.outAnimationDuration
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        return animation
    }()
    
    let rotationAnimation: CAAnimation = {
        let animation = CABasicAnimation(keyPath: Constant.rotationAnimationKeyPath)
        animation.fromValue = Constant.rotationAnimationFromValue
        animation.toValue = Constant.rotationAnimationToValue
        animation.duration = Constant.rotationAnimationDuration
        animation.repeatCount = MAXFLOAT
        
        return animation
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()

    }
    
    private func initView() {
        circularLayer.lineWidth = Constant.circularLayerLineWith
        circularLayer.fillColor = nil
        layer.addSublayer(circularLayer)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - circularLayer.lineWidth / 2
        
        let arcPath = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi/2 + (2 * Double.pi)), clockwise: true)
                
        circularLayer.position = center
        circularLayer.path = arcPath.cgPath
        
        circularLayer.add(rotationAnimation, forKey: Constant.circularLayerRotateAnimationKey)
    }
    
     func startAnimation(withColor color: CGColor = UIColor.white.cgColor) {
         circularLayer.removeAnimation(forKey: Constant.circularLayerStrokeAnimationKey)
        
        circularLayer.strokeColor = color
        strokeAnimationGroup.duration = 1.0 + outAnimation.beginTime
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.animations = [inAnimation, outAnimation]
        strokeAnimationGroup.delegate = self
        
        circularLayer.add(strokeAnimationGroup, forKey: Constant.circularLayerStrokeAnimationKey)
    }
    
     func stopAnimation() {
        circularLayer.removeAllAnimations()
    }
}


