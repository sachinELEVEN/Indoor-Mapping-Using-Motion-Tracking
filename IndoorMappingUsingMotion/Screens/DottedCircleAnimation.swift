//
//  DottedCircleAnimation.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import UIKit


class Shapes : UIViewController{
    
    var radius : CGFloat = 100
    var path : UIBezierPath? = nil
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
        
         path = UIBezierPath(arcCenter: CGPoint(x: fullWidth/2, y: 0), radius: CGFloat(radiusL), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

             
             shapeLayer.path = path!.cgPath
             

             // Change the fill color
             shapeLayer.fillColor = UIColor.clear.cgColor
             // You can change the stroke color
             shapeLayer.strokeColor = UIColor.orange.cgColor
             // You can change the line width
             shapeLayer.lineWidth = 2;
            // shapeLayer.lineJoin = CAShapeLayerLineJoin.round;
       // shapeLayer.lineCap = CAShapeLayerLineCap.round;
     
            // shapeLayer.lineDashPattern = [10,10];
            // shapeLayer.cornerRadius = 50
           
            // shapeLayer.lineDashPhase = 3.0;
             

             view.layer.addSublayer(shapeLayer)
    }
    
    func drawLineFromPoint(X:Float, ofColor lineColor: UIColor = UIColor.orange) {
print(X)
        let start = CGPoint(x: Int(X), y: 0)
        let end = CGPoint(x: Int(X), y: 200)
        
        //design the path
         path = UIBezierPath()
        path!.move(to: start)
        path!.addLine(to: end)

        //design path in layer
       
        shapeLayer.path = path!.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 16.0
        
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round

        self.view.layer.addSublayer(shapeLayer)
    }
    
    
}
//Done13
