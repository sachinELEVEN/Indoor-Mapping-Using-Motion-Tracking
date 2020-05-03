//
//  MotionTracking.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI

///Use this instance for getting relevant information about tracking.
///VM - View Model
class VMMotionTrackingInfo : ObservableObject{
    
   @Published var totalSteps : Int = 0
    @Published var totalDistance : Float = 0
   @Published  var activityTypes = [String]()
    @Published  var currentHeading : Float = 0
    
    
    
    
    
    func activities()->String{
        var act = ""
        for activity in self.activityTypes{
            act += activity + ","
        }
        if act.count != 0{
            act.removeLast()
        }
        return act
    }
    
    
    func getUserDegrees()->String{
     
       return String(Int(self.currentHeading))
  
    }
    
    
    func getInterLineSpacing(_ circleNum : Int)->CGFloat{
         /*
             Radius increases as we go towards East or West
             Radius decreases as we go towards North or South
             
             We do this using absolute value of Sin
        */
          
      //  let space = Float(fullWidth/8)
        
          let absCos = abs(cosf(self.currentHeading * Float.pi / 180))
       //  let const = 4 + 10*absCos
       // let radius = 100  + absCos*50 + (const * Float(circleNum)) + 60
     
        let interSpace = (absCos*50)*Float(circleNum) + 4
       
        return CGFloat(interSpace)
    }
    
    
    func getUserDirections()->String{
        
       /*
         N - 22
         NE - 67
         E 112 
         SE 157
         S 202
         SW 246
         W 292
         NW 337
      
         */
       
      
        
        if self.currentHeading<23 {
            return "NORTH"
        }
        else if  self.currentHeading<68 {
            return "NORTH EAST"
        }
        else if  self.currentHeading<113 {
            return "EAST"
        }
        else if  self.currentHeading<158 {
            return "SOUTH EAST"
        }
        else if  self.currentHeading<203 {
            return "SOUTH"
        }
        else if  self.currentHeading<247 {
            return "SOUTH WEST"
        }
        else if  self.currentHeading<293 {
            return "WEST"
        }
        else if  self.currentHeading<338 {
            return "NORTH WEST"
        }else {
            return "NORTH"
        }
        
     
    
      }
      
      
  
    
    
}



///Handles all motion tracking computation and its data. This is the only class that interacts with MotionViewController
class DMMotionTrackingHandler {
    
   fileprivate var trackingSessions = [DMMotionTrackingSession]()
    
    var userDirections = [Float]()
    
    ///Called By MotionViewController when a session is created.
    func addNewSession(steps:Int,distance : Float,activityTypes : [String], Start:Date, end : Date){
        
        /*
         steps recieved here will be the cummulative steps of all session so far.
         so finding steps only for this session
         */
        
        var sessionSteps = 0
        var sessionDistance : Float = 0
        
        if self.trackingSessions.count == 0{
            sessionSteps = steps
            sessionDistance = distance
        }else {
            sessionSteps = steps - self.trackingSessions[self.trackingSessions.count - 1].sessionSteps
            sessionDistance = distance - self.trackingSessions[self.trackingSessions.count - 1].sessionDistance
        }
        
        
        let newSession = DMMotionTrackingSession(sessionSteps: sessionSteps, sessionDistance: sessionDistance,sessionActivityTypes: activityTypes, sessionStartTime: Start, sessionEndTime: end)
        
        //Get Directions for this time perdiod/session
        newSession.sessionDirections = self.userDirections
        self.userDirections.removeAll()
        
        
        //updating display info
        self.updateTrackingDisplayInfo(sessionSteps: sessionSteps, sessionDistance: sessionDistance, activities: activityTypes)
        
        self.trackingSessions.append(newSession)
    }
    
    
    private func updateTrackingDisplayInfo(sessionSteps : Int,sessionDistance : Float,activities: [String]){
       
        DispatchQueue.main.async {
          
        GlobalMotionTrackingDisplayInfo.totalSteps += sessionSteps
        GlobalMotionTrackingDisplayInfo.totalDistance += sessionDistance
        GlobalMotionTrackingDisplayInfo.activityTypes.append(contentsOf: activities)
    }
    }
    
    
    
}



///Represents a single Motion Tracking Session
fileprivate class DMMotionTrackingSession {
   
    internal init(sessionSteps: Int, sessionDistance: Float, sessionActivityTypes: [String], sessionStartTime: Date, sessionEndTime: Date) {
        self.sessionSteps = sessionSteps
        self.sessionDistance = sessionDistance
        self.sessionActivityTypes = sessionActivityTypes
        self.sessionStartTime = sessionStartTime
        self.sessionEndTime = sessionEndTime
    }
    
   
    
   
   
    
       var sessionSteps : Int
       var sessionDistance : Float
    var sessionActivityTypes : [String]
       var sessionStartTime :Date
       var sessionEndTime :Date
       var sessionDirections = [Float]()
    
   
    /*
     In a single session user may change his/her directions multiple times because sesssions give us cummulative
     result of a time period.
     
     
     To get useful information like how many steps were taken in a particular direction when there are multiple direction. Here to solve this we can use time/direction and accordingly distribute steps in those directions.
    
     */
        
}
//Done50
