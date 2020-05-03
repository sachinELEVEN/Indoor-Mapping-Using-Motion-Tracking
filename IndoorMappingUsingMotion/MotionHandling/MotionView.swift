//
//  MotionView.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI

struct MotionView : UIViewControllerRepresentable {
    
    let motionManager = MotionViewController()
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MotionView>) -> MotionViewController {
        return motionManager
    }
    
    func updateUIViewController(_ uiViewController:MotionViewController, context: UIViewControllerRepresentableContext<MotionView>) {
        
    }
    
    
    //MARK:- Public Methods to interact with MotionV
    
    
    
}


///Present Any UIKit view controller as a swiftUIView
struct AnyUIKitView<T:UIViewController> : UIViewControllerRepresentable {
    
    let viewController : T
    let circleNum : Int
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AnyUIKitView>) -> T {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController:T, context: UIViewControllerRepresentableContext<AnyUIKitView>) {
      
        if let dottedCircle = uiViewController as? DottedCircle {
            dottedCircle.addCircle(radiusL: GlobalMotionTrackingDisplayInfo.getCircleRadius(self.circleNum))
       }
        
        
    }
    
    
    //MARK:- Public Methods to interact with MotionV
    
    
    
}
