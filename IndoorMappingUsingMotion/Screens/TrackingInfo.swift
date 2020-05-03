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
          
            
             UIScreenHeader(title: "Movement")
            
            label(imgName: "flame.fill", title: "Steps", content:"\(motionTrackingInfo.totalSteps)" , units: "steps")
            label(imgName: "flame.fill", title: "Distance", content:"\(Int(motionTrackingInfo.totalDistance))" , units: "metres")
//            label(imgName: "flame.fill", title: "Movement Types", content:motionTrackingInfo.activities() , units: "",small:true)
        }.padding(.horizontal)
    }
}
//Done10
