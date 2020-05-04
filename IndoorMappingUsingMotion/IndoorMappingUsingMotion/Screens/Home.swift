//
//  Home.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI


struct Home: View {
    
    var body: some View {
    NavigationView{
        ScrollView(.vertical,showsIndicators: false){
        VStack{
            //Asking for motion permission and starting pedometer
            MotionView()
            //Getting User Headings
            UserHeading()
           
            //MARK:- CUSTOM UI BELOW
            
             
            //User Movement Information
            
            
            TrackingInfo()
                

        }
        }.navigationBarTitle("")
        .navigationBarHidden(true)
        
        }
        
    }
}

//Done13

