//
//  DescLayerViewController.swift
//  progress
//
//  Created by qiaochun ji on 2018/6/27.
//  Copyright © 2018年 qiaochun ji. All rights reserved.
//

import UIKit

class DescLayerViewController: UIViewController {

    let redLayer = CALayer()
    let greeyLayer = CALayer()
    
    let drawLayer = ALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.redLayer.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(self.redLayer)
        self.redLayer.frame = CGRect(x: 50, y: 100, width: 100, height: 100)

        self.greeyLayer.backgroundColor = UIColor.green.cgColor
        self.view.layer.addSublayer(self.greeyLayer)
        self.greeyLayer.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        
        
        self.view.layer.addSublayer(self.drawLayer)
        self.drawLayer.contentsScale = UIScreen.main.scale
        self.drawLayer.borderColor = UIColor.cyan.cgColor
        self.drawLayer.borderWidth = 5.0
//
//        self.drawLayer.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let wh = self.view.frame.width - 40.0
        self.drawLayer.frame = CGRect(x: 20, y: 250, width: wh, height: wh)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.drawLayer.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//extension DescLayerViewController : CALayerDelegate{
//    func draw(_ layer: CALayer, in ctx: CGContext) {
//        ctx.setStrokeColor(UIColor.red.cgColor)
//        ctx.setLineWidth(3.0)
//        ctx.addEllipse(in: CGRect(x: 20, y: 20, width: 50, height: 50))
//        ctx.strokePath()
//    }
//}

class ALayer: CALayer {
    override func draw(in ctx: CGContext) {
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.addEllipse(in: CGRect(x: 20, y: 20, width: 50, height: 50))
        ctx.fillPath()
    }
}
