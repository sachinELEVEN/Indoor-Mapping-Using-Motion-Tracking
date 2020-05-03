//
//  DottedCircleAnimation.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import UIKit


class DottedCircle : UIViewController{
    
    var radius : CGFloat = 100
    var circlePath : UIBezierPath? = nil
    let shapeLayer = CAShapeLayer()
    
     init(radius:CGFloat){
         super.init(nibName: nil, bundle: nil)
        self.radius = radius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addCircle(radiusL: self.radius)
        
    }
    
    func addCircle(radiusL:CGFloat){
        
         circlePath = UIBezierPath(arcCenter: CGPoint(x: fullWidth/2, y: 100), radius: CGFloat(radiusL), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

             
             shapeLayer.path = circlePath!.cgPath
             

             // Change the fill color
             shapeLayer.fillColor = UIColor.clear.cgColor
             // You can change the stroke color
             shapeLayer.strokeColor = UIColor.orange.cgColor
             // You can change the line width
             shapeLayer.lineWidth = 2;
             shapeLayer.lineJoin = CAShapeLayerLineJoin.round;
             shapeLayer.lineCap = CAShapeLayerLineCap.round;
             shapeLayer.lineDashPattern = [5,5];
             shapeLayer.cornerRadius = 20
           
            // shapeLayer.lineDashPhase = 3.0;
             

             view.layer.addSublayer(shapeLayer)
    }
    
    
}
