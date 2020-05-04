//
//  TrackingInfo.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI


struct TrackingInfo: View {
    @ObservedObject var motionTrackingInfo = GlobalMotionTrackingDisplayInfo
    var body: some View {
        VStack{
            
            HStack{
                     
                           ForEach(0..<15,id:\.self){index in
                             AnyUIKitView(viewController: Shapes(radius: self.motionTrackingInfo.getInterLineSpacing(index)),lineNum:index)
                           
                           }.frame(height:200)
                            .animation(.easeIn)
                           
        }
             
                
                Text(motionTrackingInfo.getUserDegrees())
                               .font(.system(size: 120, weight: Font.Weight.black, design: Font.Design.default))
                
                
                Text(motionTrackingInfo.getUserDirections())
                                             .font(.system(size: 40, weight: Font.Weight.bold, design: Font.Design.default))
                    .foregroundColor(.secondary)
                              
                
                
                      
                       
               
          
           
            
            UIScreenHeader(title: "Movement").padding(.top)
            
            label(imgName: "flame.fill", title: "Steps", content:"\(motionTrackingInfo.totalSteps)" , units: "steps")
            label(imgName: "flame.fill", title: "Distance", content:"\(Int(motionTrackingInfo.totalDistance))" , units: "metres")

         
          
        
           // BreatheAnimation()
            
            }//.background(AnyUIKitView(viewController : BreatheAnimationViewController()))
        
        .padding(.horizontal)
           
       
        
    }
}
//Done30
