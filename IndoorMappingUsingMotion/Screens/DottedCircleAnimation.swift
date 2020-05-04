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
    
   // var lineSpacing : CGFloat = 100
  //  var drawPath : Bool = false
    var path : UIBezierPath? = nil
    let shapeLayer = CAShapeLayer()
    
    init(){
         super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if  self.drawPath{
//         //   self.drawTracedPath(zooomFactor : Float(self.lineSpacing))
//        }else{
//            //self.addCircle(radiusL: self.lineSpacing)
//        }
            
    }
    
//    func addCircle(radiusL:CGFloat){
//
//         path = UIBezierPath(arcCenter: CGPoint(x: fullWidth/2, y: 0), radius: CGFloat(radiusL), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
//
//
//             shapeLayer.path = path!.cgPath
//
//
//             // Change the fill color
//             shapeLayer.fillColor = UIColor.clear.cgColor
//             // You can change the stroke color
//             shapeLayer.strokeColor = UIColor.orange.cgColor
//             // You can change the line width
//             shapeLayer.lineWidth = 2;
//            // shapeLayer.lineJoin = CAShapeLayerLineJoin.round;
//       // shapeLayer.lineCap = CAShapeLayerLineCap.round;
//
//            // shapeLayer.lineDashPattern = [10,10];
//            // shapeLayer.cornerRadius = 50
//
//            // shapeLayer.lineDashPhase = 3.0;
//
//
//             view.layer.addSublayer(shapeLayer)
//    }
//
    func drawLineFromPoint(X:Float, ofColor lineColor: UIColor = UIColor.orange) {
//print(X)
        let start = CGPoint(x: Int(X), y: 0)
        let end = CGPoint(x: Int(X), y: 10)
        
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
    
    
  //MARK:- Traced Path Drawing
    
    func drawTracedPath(zooomFactor : Float){
        
        for subview in  self.view.subviews{
            subview.removeFromSuperview()
        }
       
        let pathFinder = VMRouteDisplayingSystem(zooomFactor:zooomFactor)
      let pathNodes = pathFinder.getPathNodes()
       
        //TEST NODES FOR PATH TRACING
//        var localNodes = [Node]()
//        let n1 = Node(x: 200, y: 450)
//          let n2 = Node(x: 300, y: 450)
//          let n3 = Node(x: 200, y:600 )
//          let n4 = Node(x: 300, y: 650)
//        localNodes.append(n1)
//          localNodes.append(n2)
//          localNodes.append(n3)
//          localNodes.append(n4)
        
        
        for i in 0..<pathNodes.count-1{
            
            let point1 = pathNodes[i]
            let point2 = pathNodes[i+1]
            let path = UIBezierPath()
            let shapeLayer = CAShapeLayer()
            
            self.drawLineBW2Points(pathL: path,shapeLayerL: shapeLayer, point1: point1, point2: point2)
         
            
        }
        
        
    }
    
    
    private func drawLineBW2Points(pathL:UIBezierPath,shapeLayerL:CAShapeLayer,point1: Node,point2 : Node,lineColor: UIColor = UIColor.orange){
        print("Printing points")
            print(point1.x,point1.y,point2.x,point2.y)
        let start = CGPoint(x: point1.x, y: point1.y)
         let end = CGPoint(x: point2.x, y: point2.y)
               
               //design the path
               // path = UIBezierPath()
               pathL.move(to: start)
               pathL.addLine(to: end)

               //design path in layer
              
               shapeLayerL.path = pathL.cgPath
               shapeLayerL.strokeColor = lineColor.cgColor
               shapeLayerL.lineWidth = 10.0
               
               shapeLayerL.lineJoin = CAShapeLayerLineJoin.round
               shapeLayerL.lineCap = CAShapeLayerLineCap.round

               self.view.layer.addSublayer(shapeLayerL)
    }
    
    
}
//Done41
