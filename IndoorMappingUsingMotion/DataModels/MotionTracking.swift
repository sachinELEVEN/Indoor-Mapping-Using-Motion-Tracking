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
    
   
    //MARK:- Handling sessionDirections
    
    
    /*
        In a single session user may change his/her directions multiple times because sesssions give us cummulative
        result of a time period.
        
        
        To get useful information like how many steps were taken in a particular direction when there are multiple direction. Here to solve this we can use time/direction and accordingly distribute steps in those directions.
       
        */
    
   
    private let stepLength :Float = 0.3//metre
    
    ///Denoting Steps in each direction
    var DirectionsStepsTable = [(Int,Int)]()//(direction,steps)
     
    ///Allowed Fluctuation Degrees (All degrees within this range of a central degree will be considered as together)
      let AFD = 20
    
    
    
    private func createDirectionsList(){
        
        
        ///Array of Array of directions(Angle With North also known as Heading)
             var directionsList_Arr = [[Int]]()
        
        var currentDL = [Int]()//DL- Degree List
        
        for direction in self.sessionDirections{
           
            var centralDeg = -1//Invalid state
            var currentDLSum = 0//Sum of all value of currentDL
            
            //Setting the central degree for the currentDL
            if currentDL.count == 0{
                currentDL.append(Int(direction))
                centralDeg = currentDL[0]
                currentDLSum += currentDL[0]
                continue
            }
            
            if abs(Int(direction)-centralDeg) < self.AFD {
                 currentDL.append(Int(direction))
            }else{
                //Need to create a new DL
                
                
                //Saving the avg of currentDL as the last element of currentDL
                let currentDLAvg = currentDLSum/currentDL.count
                currentDL.append(currentDLAvg)
                
                
                //saving the previous DL
                directionsList_Arr.append(currentDL)
               
                //Resetting the currentDL and central degree
                currentDL.removeAll()
                 centralDeg = -1
                
                //Saving directon in the new currentDL
                currentDL.append(Int(direction))
                centralDeg = currentDL[0]
               
            }
             
        }
        
       
        self.createADL(directionsList_ArrP : directionsList_Arr)
        
    }
    
   ///ADL - Array of Directions List , Array of avg of each DL in self.directionsList_Arr
    private func createADL(directionsList_ArrP : [[Int]]){
        
        var directionsList_Arr = directionsList_ArrP
        
         ///Average of Directions List2,  Array of avg of degrees of each DL with the DL length in self.directionsList_Arr
         var ADL = [(Int,Int)]()//(Average,length)
        var modifiedDirectionLength = -1 //Invalid State
        
         var directionsLength = 0//Sum of all lengths in ADL
        
        for i in 0..<directionsList_Arr.count-1{
            
            var count1 = directionsList_Arr[i].count - 1
            let count2 = directionsList_Arr[i+1].count - 1
            
           
           
            let avg1 = directionsList_Arr[i][count1]
            let avg2 = directionsList_Arr[i+1][count2]
            
            if modifiedDirectionLength != -1{
                          count1 = modifiedDirectionLength
                       }
            
            if abs(avg1 - avg2) < self.AFD{
                let avg3 = (avg1+avg2)/2 //avg is direction
               modifiedDirectionLength = count1+count2
                
                directionsList_Arr[i+1][count2] = avg3
                
                 //let ADL2Element = (avg3,count1+count2)
                
               // ADL.append(ADL2Element)
                
                //directionsLength += count1 + count2
                
            }else{
                
                
                let ADL2Element = (avg1,count1)
                
                ADL.append(ADL2Element)
                
                directionsLength += count1
                
                modifiedDirectionLength = -1
            }
            
           
        }
        
        
       
              //Handling the last element of directionsList_Arr
        let outerLast = directionsList_Arr.count - 1
        let innerLast = directionsList_Arr[outerLast].count - 1
        let avg = directionsList_Arr[outerLast][innerLast]
        let ADL2Element = (avg,modifiedDirectionLength == -1 ? innerLast : modifiedDirectionLength)
                                      
                                      ADL.append(ADL2Element)
                                      
                                      directionsLength += modifiedDirectionLength
                       
                       
                       
              
        
        
        self.createDirectionStepTable(ADL:ADL,totalDirections: directionsLength)
        
    }
    
    
    private func createDirectionStepTable(ADL:[(Int,Int)],totalDirections : Int){
        
        let stepsPerDirection = self.sessionSteps/totalDirections
        
        for element in ADL{
            //elemet = (direction,length)
            
            let direction = element.0
            let length = element.1
            
            let stepsinElementDirection = stepsPerDirection * length
            
            let directionAndSteps = (direction,stepsinElementDirection)
            self.DirectionsStepsTable.append(directionAndSteps)
            
        }
        
        self.resetAptData()
        
    }
    
    
    private func displayPath(){
        
         print("Path is shown below")
       
        for directionalPath in self.DirectionsStepsTable{
           
            print("Direction : ",directionalPath.0, " Steps ", directionalPath.1 )
            
        }
        
        print("Path Ends")
        
    }
    
    
    private func resetAptData(){
        
    }
    
    
    
    
        
}
//Done62


