import UIKit
import CoreMotion
import Dispatch


class MotionViewController: UIViewController {

    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    private var activityTypes = [String]()

 
   // @IBOutlet weak var stepsCountLabel: UILabel!
   // @IBOutlet weak var activityTypeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
       
    }

    
   ///Start/Stops Motion Tracking Depending on the Current State. Returns TRUE if tracking is started
    func startMotionTracking()->Bool{
        shouldStartUpdating = !shouldStartUpdating
               shouldStartUpdating ? (onStart()) : (onStop())
        
         return shouldStartUpdating ? true : false
    }
    
    
}


extension MotionViewController {
    private func onStart() {
       
        startDate = Date()
        checkAuthorizationStatus()
        startUpdating()
    }

    private func onStop() {
      
        startDate = nil
        stopUpdating()
    }

    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
           // activityTypeLabel.text = "Not available"
        }

        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
           // stepsCountLabel.text = "Not available"
        }
    }

    private func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            onStop()
           // activityTypeLabel.text = "Not available"
           // stepsCountLabel.text = "Not available"
        default:break
        }
    }

    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }

    private func on(error: Error) {
        //handle error
        print("Got Error")
    }

   

    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                    self!.activityTypes.append("walking")
                } else if activity.stationary {
                    self!.activityTypes.append("Stationary")
                } else if activity.running {
                    self!.activityTypes.append("Running")
                } else if activity.automotive {
                    self!.activityTypes.append("Automotive")
                   
                }
            }
        }
    }

    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }

            let steps = Int(pedometerData.numberOfSteps.stringValue)!
            let distance = Float(truncating: pedometerData.distance ?? 0)
            let start = pedometerData.startDate
            let end = pedometerData.endDate
            
            //Creating a new tracking session
            GlobalMotionTrackingHandler.addNewSession(steps: steps, distance: distance, activityTypes: self!.activityTypes, Start: start, end: end)
            
           //Resetting activity for new session
            self!.activityTypes.removeAll()
               
          
            
        }
    }
}
