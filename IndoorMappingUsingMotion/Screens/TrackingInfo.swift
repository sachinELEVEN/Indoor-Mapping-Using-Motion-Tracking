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
          
            Text(motionTrackingInfo.getUserDirections())
                .font(.system(size: 120, weight: Font.Weight.black, design: Font.Design.default))
            
            UIScreenHeader(title: "Movement").padding(.top)
            
            label(imgName: "flame.fill", title: "Steps", content:"\(motionTrackingInfo.totalSteps)" , units: "steps")
            label(imgName: "flame.fill", title: "Distance", content:"\(Int(motionTrackingInfo.totalDistance))" , units: "metres")

            
            ZStack{
            
                  ForEach(0...10,id:\.self){index in
                    AnyUIKitView(viewController: DottedCircle(radius: self.motionTrackingInfo.getCircleRadius(index)),circleNum:index)
                  }
                  }
            
            
        }.padding(.horizontal)
    }
}
//Done27
