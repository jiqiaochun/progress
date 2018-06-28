//
//  ProgreeViewController.swift
//  progress
//
//  Created by qiaochun ji on 2018/6/27.
//  Copyright © 2018年 qiaochun ji. All rights reserved.
//

import UIKit

class ProgreeViewController: UIViewController {

    let slider = UISlider(frame: CGRect.zero)
    
    let layerOne = ProgressOneLayer()
    let layerTwo = ProgressTwoLayer()
    let layerThree = ProgressThreeLayer()
    let layerFour = ProgressFourLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.slider)
        self.slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        self.view.layer.addSublayer(layerOne)
        self.layerOne.number = 0.0
        self.view.layer.addSublayer(layerTwo)
        self.layerTwo.number = 0.0
        self.view.layer.addSublayer(layerThree)
        self.layerThree.number = 0.0
        self.view.layer.addSublayer(layerFour)
        self.layerFour.number = 0.0
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.slider.frame = CGRect(x: 50, y: 70, width: self.view.frame.width-100, height: 30)
        
        let lwh = 100.0
        let horSpace = (Double(self.view.frame.width) - Double(2*lwh)) / 3.0
        
        self.layerOne.frame = CGRect(x: horSpace, y: 110, width: lwh, height: lwh)
        self.layerTwo.frame = CGRect(x: horSpace+20+lwh, y: 110, width: lwh, height: lwh)
        self.layerThree.frame = CGRect(x: horSpace, y: 110+lwh+30, width: lwh, height: lwh)
        self.layerFour.frame = CGRect(x: horSpace+20+lwh, y: 110+lwh+30, width: lwh, height: lwh)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sliderValueChanged() {
        self.layerOne.number = Double(self.slider.value)
        self.layerTwo.number = Double(self.slider.value)
        self.layerThree.number = Double(self.slider.value)
        self.layerFour.number = Double(self.slider.value)
    }
}

// 圆形进度条的父类，用于显示百分数
class ProgressLayer: CALayer {
    
    var number : Double = 0.0{
        didSet{
            self.tLayer.string = String(format: "%.0f%%", number*100)
            self.tLayer.setNeedsDisplay()
            self.setNeedsDisplay()
        }
    }
    
    let tLayer : CATextLayer = {
        let l = CATextLayer()
        let font = UIFont.systemFont(ofSize: 12)
        l.font = font.fontName as CFTypeRef
        l.fontSize = font.pointSize
        l.foregroundColor = UIColor.black.cgColor
        l.alignmentMode = kCAAlignmentCenter
        l.contentsScale = UIScreen.main.scale
        l.isWrapped = true
        l.string = ""
        return l
    }()
    
    override init() {
        super.init()
        self.addSublayer(tLayer)
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSublayers() {
        super.layoutSublayers()
        let th = NSString(string: "100%").boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)], context: nil).height
        self.tLayer.frame = CGRect(x: 0, y: self.frame.height*0.5-th*0.5, width: self.frame.width, height: th)
    }
    
}

class ProgressOneLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        
        let radius = self.frame.width * 0.45
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setStrokeColor(UIColor.cyan.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(.round)
        
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
    }
}

class ProgressTwoLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        
        let radius = self.frame.width * 0.45
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setFillColor(UIColor.yellow.cgColor)
        
        ctx.move(to: center)
        ctx.addLine(to: CGPoint(x: self.frame.width * 0.5, y: self.frame.height * 0.05))
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: -0.5 * CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.closePath()
        
        ctx.fillPath()
        
    }
}

class ProgressThreeLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        
        let radius = self.frame.width * 0.45
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.3).cgColor)
        ctx.setLineWidth(radius*0.07)
        ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
        ctx.strokePath()
        
        ctx.setFillColor(UIColor.orange.cgColor)
        
        let startAngle = 0.5 * CGFloat.pi - CGFloat(self.number) * CGFloat.pi
        let endAngle = 0.5 * CGFloat.pi + CGFloat(self.number) * CGFloat.pi
        ctx.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        ctx.closePath()
        
        ctx.fillPath()
        
    }
}

class ProgressFourLayer: ProgressLayer {
    override func draw(in ctx: CGContext) {
        
        let radius = self.frame.width * 0.45
        let center = CGPoint(x: self.frame.width*0.5, y: self.frame.height*0.5)
        
        ctx.setStrokeColor(UIColor.gray.withAlphaComponent(0.8).cgColor)
        ctx.setLineWidth(radius*0.07)
        ctx.addEllipse(in: CGRect(x: self.frame.width*0.05, y: self.frame.height*0.05, width: self.frame.width*0.9, height: self.frame.height*0.9))
        ctx.strokePath()
        
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.setLineWidth(radius * 0.08)
        ctx.setLineCap(.round)
        
        let endAngle = CGFloat(self.number) * CGFloat.pi * 2.0 - CGFloat.pi * 0.5
        ctx.addArc(center: center, radius: radius, startAngle: -0.5*CGFloat.pi, endAngle: endAngle, clockwise: false)
        ctx.strokePath()
        
    }
}

