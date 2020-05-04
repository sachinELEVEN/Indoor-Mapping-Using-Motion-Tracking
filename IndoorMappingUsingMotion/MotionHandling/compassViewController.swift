//
//  compassViewController.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

struct UserHeading : UIViewControllerRepresentable {
 

    func makeUIViewController(context:  UIViewControllerRepresentableContext<UserHeading>) -> CompassAccess {
        return CompassAccess()
    }

    func updateUIViewController(_ uiViewController: CompassAccess, context:  UIViewControllerRepresentableContext<UserHeading>) {

    }
    
    

    class CompassAccess : UIViewController,CLLocationManagerDelegate {

     var locationManager = CLLocationManager()
     var rePoint = true

     override func viewDidLoad() {
           super.viewDidLoad()
         //Asks for user's location services
         locationManager.delegate = self
         
          // locationManager.requestWhenInUseAuthorization()
         //Start the compass
          locationManager.startUpdatingHeading()
        
        }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
         
     //update global variable keeping track of heading // Bad practice
       
       // print(self.locationManager.heading?.magneticHeading.description)
     let heading =  Float(self.locationManager.heading?.magneticHeading.description ?? "0" )!
     
     if (abs(heading-GloabalCurrentDeviceHeading)<1){
       //  print("not enough rotation")
         return
     }
     
        //Getting user heading here
     GloabalCurrentDeviceHeading = heading
        GlobalMotionTrackingDisplayInfo.currentHeading = heading
    GlobalMotionTrackingHandler.userDirections.append(heading)
     
     
     
     
         }



     }

}



//Done8
