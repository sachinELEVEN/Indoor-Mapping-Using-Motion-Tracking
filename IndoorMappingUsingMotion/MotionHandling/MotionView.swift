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
    let lineNum : Float
    let drawPath : Bool
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AnyUIKitView>) -> T {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController:T, context: UIViewControllerRepresentableContext<AnyUIKitView>) {
      
        if let shapes = uiViewController as? Shapes {
            
            if drawPath{
                shapes.drawTracedPath(zooomFactor : self.lineNum)
            }
            else{
            shapes.drawLineFromPoint(X: Float(GlobalMotionTrackingDisplayInfo.getInterLineSpacing(Int(self.lineNum))))
            }
       }
        
    }
}



struct TrackedPath : View{
    @State var zoom : Float = 5
    var body : some View{
        VStack{
//            Text("Path")
//                .fontWeight(.heavy)
//                .font(.largeTitle)
//            .padding(.top,30)
            ZStack(alignment:.bottom) {
                AnyUIKitView(viewController: Shapes(),lineNum: self.zoom,drawPath: true)
                       .background(CustomBlur(style: .systemUltraThinMaterial))
                       .cornerRadius(10)
                    .frame(width:fullWidth/1.05,height:fullHeight/1.2)
                    .padding(.horizontal)
                    .padding(.bottom)
                Slider(value: $zoom, in: 1...40,step:0.3)
                    .padding(.bottom,30)
                    .padding(.horizontal,30)
                    
        }
        }
    }
}
//Done25
