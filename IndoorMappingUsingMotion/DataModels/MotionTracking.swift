//
//  MotionTracking.swift
//  IndoorMappingUsingMotion
//
//  Created by sachin jeph on 03/05/20.
//  Copyright © 2020 sachin jeph. All rights reserved.
//

import Foundation

///Use this instance for getting relevant information about tracking.
///VM - View Model
class VMMotionTrackingInfo : ObservableObject{
    
   @Published var totalSteps : Int = 0
    @Published var totalDistance : Float = 0
   @Published var activityTypes = [String]()
    
    
}



///Handles all motion tracking computation and its data. This is the only class that interacts with MotionViewController
class DMMotionTrackingHandler {
    
   fileprivate var trackingSessions = [DMMotionTrackingSession]()
    
    
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
        newSession.sessionDirections = []
        
        
        //updating display info
        self.updateTrackingDisplayInfo(sessionSteps: sessionSteps, sessionDistance: sessionDistance, activities: activityTypes)
        
        self.trackingSessions.append(newSession)
    }
    
    
    private func updateTrackingDisplayInfo(sessionSteps : Int,sessionDistance : Float,activities: [String]){
       
        GlobalMotionTrackingDisplayInfo.totalSteps += sessionSteps
        GlobalMotionTrackingDisplayInfo.totalDistance += sessionDistance
        GlobalMotionTrackingDisplayInfo.activityTypes.append(contentsOf: activities)
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
//Done20
