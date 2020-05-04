//
//  VectorSystem.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import UIKit

///Responsible for displaying routes of mapped routes

class Node{
    internal init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    var x : Int
    var y : Int
    var color : UIColor = .orange
}

class VMRouteDisplayingSystem:ObservableObject{
    
   
    
    private var completePath = [[(Int,Float)]](){
    didSet{
        print("Complete Path has been updated")
        }
    }
    
    deinit{
        print("Computing Path")
    }
    
  private var pathNodes = [Node]()
    
    func getPathNodes(zoomFactor : Float)->[Node]{
       self.computePathNodes(zoomFactor : zoomFactor)
        return self.pathNodes
    }
    
    func computePathNodes(zoomFactor : Float,getPath:Bool = false){
    
        if getPath{
            completePath = GlobalMotionTrackingHandler.getPath()
        }
        
        self.pathNodes.removeAll()
        
       
       
       
        let originNode = Node(x: Int(fullWidth/2), y: Int(fullHeight/2))
        self.pathNodes.append(originNode)
        var previousNode : Node = originNode
        
        for path in completePath{
            
            
            
            for pathPoint in path{
                //direction is wrt NORTH
                let direction = pathPoint.0
                let steps = pathPoint.1
                let magnitude : Float = zoomFactor*steps
               
                
                let relativeX = Int(magnitude*sinf(Float(direction) * Float.pi / 180))
                let relativeY = Int(magnitude*cosf(Float(direction) * Float.pi / 180))
                
                
                
                //X and Y of previous Node
                let offsetX = previousNode.x
                let offsetY = previousNode.y
                
                
                let newNode = Node(x: offsetX+relativeX, y: offsetY+relativeY)
                newNode.color = self.getPointColor(direction: Float(direction))
                
                //Adding newNode
                self.pathNodes.append(newNode)
                
                previousNode = newNode
               
                
            }
            
            
        } 
        
        
    }
    
    
    private func getPointColor(direction:Float)->UIColor{
        
        if direction<23 {
                return UIColor.systemOrange
             }
             else if  direction<68 {
                return UIColor.systemBlue
             }
             else if  direction<113 {
               return UIColor.systemRed
             }
             else if  direction<158 {
                return UIColor.systemPink
             }
             else if  direction<203 {
            return UIColor.systemYellow
             }
             else if  direction<247 {
                return UIColor.systemRed
             }
             else if  direction<293 {
            return UIColor.systemPurple
             }
             else if  direction<338 {
               return UIColor.systemIndigo
             }else {
                 return UIColor.systemOrange
             }
        
        
    }
    
    
    
}
//Done83
